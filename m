Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCHUNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCHUNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:13:23 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:62108 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261179AbUCHULO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:11:14 -0500
Date: Mon, 8 Mar 2004 14:58:29 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040308195829.GB2099@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com> <c25jbl$732$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25jbl$732$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed.  Good catch David.

JLC

On Wed, Mar 03, 2004 at 09:40:05PM +0000, David Wagner wrote:
> Jean-Luc Cooke  wrote:
> >Christophe and I's scheme of IV = firstIV + blockNum
> >for initial setup and IV = IV + 2^64 for IV updates will work fine
> 
> That's not ideal.  I'd suggest IV = HMAC_k(firstIV, blockNum) or somesuch.
> Sequential IV's aren't a good choice with CBC -- they can leak a little
> bit of information about the first block of plaintext, in some cases.

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6

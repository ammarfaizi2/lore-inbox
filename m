Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEVMFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 08:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEVMFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 08:05:07 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:32444 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261786AbTEVMFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 08:05:06 -0400
Date: Thu, 22 May 2003 08:17:49 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: Strange terminal problem with 2.5.6[8-9]
In-reply-to: <1053581519.6507.22.camel@workshop.saharact.lan>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1054037874.c3b3f2@bittwiddlers.com>
Message-id: <20030522121749.GA1173@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <20030511004349.GA1366@bittwiddlers.com>
 <20030522013601.GA1327@bittwiddlers.com>
 <1053581519.6507.22.camel@workshop.saharact.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: 2.5.68 and later have depreciated devpts support in devfs.  Thus
: you have to enable:
: 
:  CONFIG_DEVPTS_FS=y
: 
: and mount it during boot.  Easy way is just to add to fstab:
: 
: ------------------
: none	/dev/pts	devpts	defaults	0 0
: ------------------

Sure enough that was it.  Darn it.  I must have missed that change entirely.
I was compiling in devpts but still figured it was mutually exclusive with
devfs (which I am using).

Thanks

-- 
  Matthew Harrell                          Never raise your hand to your 
  Bit Twiddlers, Inc.                       children - it leaves your
  mharrell@bittwiddlers.com                 midsection unprotected.

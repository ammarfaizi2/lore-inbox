Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTGWN2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTGWN2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:28:47 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:1555 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270321AbTGWN2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:28:46 -0400
Date: Wed, 23 Jul 2003 14:43:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Felker <tcfelker@mtco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root= needs hex in 2.6.0-test1-mm2
Message-ID: <20030723144351.A3367@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Felker <tcfelker@mtco.com>, linux-kernel@vger.kernel.org
References: <200307230156.40762.tcfelker@mtco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307230156.40762.tcfelker@mtco.com>; from tcfelker@mtco.com on Wed, Jul 23, 2003 at 01:56:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:56:40AM -0500, Tom Felker wrote:
> I finally booted 2.6.0-test1-mm2, after reading somebody else who needed to 
> use hex in the root= argument.  root=/dev/hdb1 and root=hdb2 would panic 
> ("VFS: Cannot open root device hdb1 or unknown-block(0,0)"), but root=0341 
> worked.  Devfs is compiled in, devfs=nomount and devfs=mount make no 
> difference.  Is this intentional?

Yes.  If you use devfs you have to use devfs names for root=.  It's
pretty simple.  Best option of course is to avoid devfs.


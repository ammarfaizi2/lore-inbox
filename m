Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVCIGVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVCIGVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCIGVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:21:03 -0500
Received: from pop-9.dnv.wideopenwest.com ([64.233.207.43]:12165 "EHLO
	pop-9.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S262096AbVCIGUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:20:39 -0500
Date: Wed, 9 Mar 2005 01:20:36 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Pktcdvd and DVD RW drive.
Message-ID: <20050309062036.GB7918@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
References: <200503082256.34965.assirati@nonada.if.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503082256.34965.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jo?o Luis Meloni Assirati <assirati@nonada.if.usp.br>, on Tue Mar 08, 2005 [10:56:34 PM] said:
> Hello,
> 
> I have an
> 
>  hdc: HL-DT-ST DVDRAM GSA-4120B, ATAPI CD/DVD-ROM drive
> 
> from LG. My kernel is a vanilla 2.6.11 with packet writing enabled. I noticed, 
> however, that I can mount and write a CD-RW udf formatted with 
> 
> # cdrwtool -d /dev/hdc -q
> 
> without the need of the pktcdvd driver (with the module unloaded, indeed), 
> simply with
> 
> # mount -t udf /dev/hdc /mnt
> 
> I thought that this was a property only of DVD+RW and DVDRAM media. Am I 
> missing something here? What is then the use of pktcdvd driver?
> 
> Thanks in advice,
> Joao Luis M. Assirati.

	Hi;

	Well, I have only tested this with dvd+rw (and mount with the
noatime option, to avoid wearing out your media), and it is just *way*
to slow, vs. pktcdvd. I gave up on a copy that would have taken a minute
or two under pktcdvd after over an hour with just the block device
mount.
	Of course, pktcdvd gives me and others pretty consistant data
corruption. (see bug 4290 on bugzilla.kernel.org)

Paul
set@pobox.com

ps. others have reported that mt. rainier support works well, and obviates
pktcdvd.

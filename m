Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTDPPri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTDPPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:47:38 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:54027 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264462AbTDPPrg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:47:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: How to identify contents of /lib/modules/*
Date: Wed, 16 Apr 2003 10:58:48 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064045133AB@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to identify contents of /lib/modules/*
Thread-Index: AcMEK6SoQGVl9lqlQcSu8ZdCOEaXDgAAWdcQ
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Apr 2003 15:59:25.0071 (UTC) FILETIME=[26FFC1F0:01C30431]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Mer, 2003-04-16 at 03:00, Stephen Cameron wrote:
> > The task for the binary driver distributor becomes to figure out which
> > of these multiple errata kernels found in /boot corresponds to the 
> > /lib/modules directory, so we can drop the binary driver that was
> > made for that errata kernel in there, and not a driver made for the
> > wrong kernel.
> 
> if its an rpm based distro
> 
> 	rpm -qf /lib/modules/[version]/something
> 
> will tell you which kernel owns the file.
[...]

Yep. I thought of that too, which is why I had also written:

steve> Also, rpm -qf to try to id the RPM from which some /lib/modules file
steve> or vmlinuz won't necessarily work, as rpm can report they belong to 
steve> multiple RPMs in certain cases.

I think it's the use of "--force" option to RPM that causes this,
or else, faulty RPMs.  It's not so easy to make a well-behaved
RPM.  Having tried myself, sometimes I think maybe RPM 
really stands for "Revolting Pile of Manure". (no offense ;-) Of 
course I'm probably trying to bend it do a job for which perhaps 
it is not so well suited.

-- steve


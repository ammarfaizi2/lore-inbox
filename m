Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWC3P6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWC3P6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWC3P6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:58:18 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:51716 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751184AbWC3P6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:58:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060330153128.GB9811@unthought.net>
x-originalarrivaltime: 30 Mar 2006 15:58:08.0651 (UTC) FILETIME=[BD2B3DB0:01C65412]
Content-class: urn:content-classes:message
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
Date: Thu, 30 Mar 2006 10:58:08 -0500
Message-ID: <Pine.LNX.4.61.0603301053030.738@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NFS/Kernel Problem: getfh failed: Operation not permitted
Thread-Index: AcZUEr00zDcZVcbbRs+4aiwjtP1rOA==
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300929340.18696@p34> <1143729766.8074.49.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300949000.18696@p34> <1143731364.8074.53.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603301011160.18696@p34> <20060330153128.GB9811@unthought.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jakob Oestergaard" <jakob@unthought.net>
Cc: "Justin Piszcz" <jpiszcz@lucidpixels.com>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2006, Jakob Oestergaard wrote:

> On Thu, Mar 30, 2006 at 10:13:38AM -0500, Justin Piszcz wrote:
>> On Thu, 30 Mar 2006, Trond Myklebust wrote:
>>
> ...
>> In the /etc/exports file, I have an entry that looks like this:
>> /path	specific-host-001(ro,root_squash,no_sync)
>> /path	specific-host-002((ro,root_squash,no_sync)
>> /path	*(ro,root_squash,no_sync)
>
> I don't know how this works today, but historically Linux has been
> completely unable to deal with any kind of names in /etc/exports.
> Netgroups, DNS names, ...  And the results have been the strangest mix
> of things sort-of-mostly-but-not-quite working.
>
> I'd put in IP addresses, netmasks or '*', and see if that solves the
> problem.
>
> Again, I don't know if this is related to what you're seeing, but I'd
> say it's worth a shot :)
>
> --
>
> / jakob
>


This is my /etc/exports and it works fine with linux-2.6.15.4.
All the host names are local, inside the firewall, and need to
be looked-up over a W$<crap> name-server.

#
/rmtboot/LinuxRoot	*(ro,async)
/root/Scanner	*(ro,no_root_squash,sync)
/tmp		*(rw,no_root_squash,sync)
/usr/src	quark(rw,no_root_squash,sync)
/usr/lib	quark(rw,no_root_squash,sync)
/home/hpbd	*(rw,no_root_squash,sync)
/exports	*(rw,no_root_squash,sync)
/home/project/boneserver	*(rw,no_root_squash,sync)
/root		groveland(rw,no_root_squash,sync)
/root		quark(rw,no_root_squash,sync)
/root/DAS	*(ro,no_root_squash,sync)
/dos/drive_C	*(ro,sync)
# End of exports.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbTI3N3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTI3N3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:29:34 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:56457 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261470AbTI3N31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:29:27 -0400
Date: Tue, 30 Sep 2003 15:26:54 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301326.h8UDQsIM004454@burner.fokus.fraunhofer.de>
To: axboe@suse.de, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From davem@redhat.com  Tue Sep 30 14:28:23 2003

>On Tue, 30 Sep 2003 14:06:29 +0200
>Jens Axboe <axboe@suse.de> wrote:

>> I asked you one simple question: when did the kernel/user interface
>> break, and how?

>I'll answer for him, about 20 or 30 times during IPSEC development.
>It's still possible this could change even some more before 2.6.0
>final is released if a large enough bug in the IPSEC socket APIs are
>found in time.

There is a simple rule of thumb:

If the kernel code is not even ready for testing: don't inlcude it
in external releases.

If it makes sense to test the code and it uses new interfaces then you
need to make the interfaces available to potential users of the interface.
If the interface is going to change then the user should be informed about the
fact, but you yould need the kernel interface include files.

glibc exports own interaces and for this reason needs to supply own include 
files. I see no reason however that glibc should deal with include files that
do not even affect glibc code. This is true for most ioctl()s,
it is definitely true for the SCSI related ioctl()s.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

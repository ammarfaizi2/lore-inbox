Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTIDWlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265601AbTIDWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:41:07 -0400
Received: from [205.200.104.254] ([205.200.104.254]:47295 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S265586AbTIDWlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:41:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 17:41:02 -0500
Message-ID: <18DFD6B776308241A200853F3F83D50727B3@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Thread-Index: AcNzIoC0F/OgNqn3QyOTfeVYr832twAC+goQ
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: <jimwclark@ntlworld.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark [mailto:jimwclark@ntlworld.com]
> 
> Thank you for this (and the few other) sensible appraisal of 
> my 'proposal'. 
> 
> I'm very surprised by the number of posts that have ranted 
> about Open/Close source, GPL/taint issues etc. This is not
> about source code it is about making Linux usable by the 
> masses. It may be technically superior to follow the current 
> model, but if the barrier to entry is very high (and it is!) 
> then the project will continue to be a niche project. A 
> binary model doesn't alter the community or the benefits 
> of public source code. I agree that it is an extra interface 
> and will carry a performance hit - I think this is worth it. 
> Windows has many faults but drivers are often compatible across 
> major releases and VERY compatible across minor releases. It 
> is no accident that it has 90% of the desktop market. If we are 
> going to improve this situation this issue MUST be confronted.

I'll admit, I don't see how a binary only interface helps easy of use.  For the most part, common users in the Windows world can't handle installing a driver any better than they would be able to in Linux.

Now, before going any further with your proposal, look at http://www.projectudi.org/, who were commited to doing exactly what you propose with even more ambition dreams of cross OS compatibility.  It was a Caldera/SCO project, so it's more than likely dead on the Linux side, but you can see the technical description, specifications, and even source code for this type of  endevour.

You can read the some of the UDI debate at:
http://lkml.org/lkml/1998/9/18/37
http://lkml.org/lkml/1998/8/31/63

The problems with such an API are very numerous.  For an example, just look at Windows NT 4.0 versus Windows 2000 versus Windows XP or Windows 95->Windows 98->Windows 98SE->Windows ME.  In both those cases, the individual revisions have the same basic driver model, but added features in each made drivers from the previous one more or less incompatible with the newly released OS.  Now, lets assume a project like UDI was accepted into Linux.  What would happen when technology evolves, and the old stuff becomes obsolete?  Will Linux have to always refer to devices on fancy new buses as if they were on old PCI buses?  What happens when some core OS bug fix breaks three or four different drivers?  Will Linux have to incorporate bug workarounds for those defective drivers?  What will happen when the binary API for device drivers starts making the Windows DDK look simple?  The Linux module API is very, very simple compared to most other OS's driver API.  Someone can learn to make their first kernel driver in a few hours, and even have it talking to hardware within that time.

Source code for drivers is an advantage for Linux.  It ensures that anyone can have a chance to fix quirky bugs that are getting in the way of them using their computer to it's fullest.  I used to have problems with some particular 3c905 cards with Linux 2.4.  If I had been using binary drivers, my only recourse would be to try and pester the vendor (3COM) for a fix.  Instead, I found a trivial patch to the kernel that I applied, and recompiled, and got the cards working without a hitch.  You could try to argue that the commerical released driver would not have a problem like this, but it would likely also come with a compatibility list that only said it works on Red Hat 6.2, and Red Hat 7.0, and with me running Debian, I'd be out of luck -- no support, even if it SHOULD work.

The reality is that most people will simply use whatever their distributor has given them.  If it's Red Hat, they'll use whatever came with their Red Hat CDs.  If it came with a handy CD with install instructions, they might try to install that.  Otherwise, they'll hire a qualified person to do the work for them, exactly as if it were a Windows machine.  There have been no end of the people who insist that Linux is too hard to use because compiling the kernel is too difficult, and the obvious suggestion is then, to not compile the kernel and just use whatever your distributor gave you instead!  Most people won't need to worry about the source code, and may never need to touch it, but the fact that it's there for them, gives them some power that they otherwise would not have.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTEFI2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTEFI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:28:09 -0400
Received: from exch.niss.ac.uk ([212.219.213.39]:1639 "EHLO exch.niss.ac.uk")
	by vger.kernel.org with ESMTP id S262454AbTEFI2I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:28:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Failing to allocated file handles?
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Tue, 6 May 2003 09:40:34 +0100
Message-ID: <4AF1125777E862438AF19388C54860C9220553@exch.office.niss.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Failing to allocated file handles?
Thread-Index: AcMTqykNJucWeiSbQ4GQsYOUw00X+w==
From: "Jamie Harris" <jamie.harris@eduserv.org.uk>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Sorry if this isn't the kind of thing you guys deal with, if this is the
case then feel free to tell me a better place to ask my question!  I
haven't managed to find anywhere else that's got lots of people who know
a sufficient amount about kernel internals.

We've got an SMP P3 server running Redhat's (sorry, I would roll my own
but it's not 'my' box) 2.4.18-27.7.xsmp kernel.  This box runs Apache
and ColdFusion (spit!).  The ColdFusion (spit!) server appears to decide
to open a number of files in a short burst, then promptly dies.  I've
worked out from monitoring /proc/sys/fs/file-nr that we're running out
of available file handles.  The number of allocated file handles (sorry
if my terminalogy is way off, I'm talking about the first number in
/proc/sys/fs/file-nr) hovers around 2500, the number of available file
handles (the second number) drops to around zero, then gets to zero and
the ColdFusion (spit!) server dies and reports being out of files.

It appears that the system is not allocating new file handles fast
enough to keep up with the rate they are being consumed.  Is this
possible?  I'm unable to replicated this on a single processor machine
so am assuming that it's related to different threads on different CPUs
not 'keeping up with one another'.  

What do the kernel devlopers think?  Any info creatly appreaciated, even
if its only "get and build the latest kernel", at least I'll have some
more info to tell our customer and the powers-that-be.  Oddly enough
we're only experiencing this on a single machine, although we have lots
of identical boxes running similar software.

Cheers all.

Jamie...

--
Jamie Harris, NISS Service Delivery Team, 
EduServ, Queen Anne House, 11 Charlotte Street, Bath, BA1 2NE
Tel: +44 (0)1225 474300 Fax: +44 (0)1225 474301
Direct Tel: +44 (0)1225 474388

**  This message was transmitted on 100% recycled electrons **


 

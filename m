Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbULFRaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbULFRaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbULFRaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:30:15 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:25749 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261584AbULFR3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:29:22 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-20.tower-45.messagelabs.com!1102354159!8144439!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: FS Corruption [Re: Linux 2.6.10-rc3]
Date: Mon, 6 Dec 2004 12:29:17 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC414D@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FS Corruption [Re: Linux 2.6.10-rc3]
Thread-Index: AcTbuN4d1PMmmwdYT2y0zWxpLU1ZKgAABeoA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also got FS corruption with XFS under 2.6.10-rc2.
Booting back to 2.6.9 did not fix the problem, had to re-install.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kristofer T.
Karas
Sent: Monday, December 06, 2004 12:23 PM
To: Linus Torvalds
Cc: Kernel Mailing List
Subject: FS Corruption [Re: Linux 2.6.10-rc3]

Linus Torvalds wrote:

>Ok, it's out there in all the normal places, and here's the shortlog
for
>the thing.
>

Hi Linus - I'm seeing filesystem corruption (on ext3 anyway) with -rc3; 
there is no such corruption on -rc2.  It would be better if somebody 
with a clue reported this; but since I haven't seen anything, I thought 
I'd hollar before somebody loses work as a result.  (Everybody does real

work on -rc kernels, don't they? :-)

I untarred a kernel tarball into a directory, renamed it "foo", reboot 
(to clear disk cache), and then did this:

pinhead:/usr/src/kernels# rm -r foo &
[1] 3268
pinhead:/usr/src/kernels# tar xzf linux-2.6.9.tar.gz
rm: cannot remove `foo/include/asm-ppc/linkage.h': No such file or
directory
rm: cannot remove `foo/include/asm-x86_64/rtc.h': No such file or
directory
rm: cannot remove `foo/include/asm-m68knommu/mcftimer.h': No such file
or directory
rm: cannot remove `foo/include/asm-m68k/linkage.h': No such file or
directory
rm: cannot remove `foo/include/asm-sparc64/rwsem.h': No such file or
directory
rm: cannot remove `foo/include/asm-sparc/psr.h': No such file or
directory
[1]+  Exit 1                  rm -r foo
pinhead:/usr/src/kernels#


Running e2fsck on the next boot reports I've got a damaged filesystem.

System is a generic PC (a Dell GX110) - I810 chipset, PIII, IDE.  
Untainted vanilla kernel.  Other config details upon request.

Kris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbULFRXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbULFRXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbULFRXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:23:54 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:49328 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261584AbULFRXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:23:32 -0500
Message-ID: <41B4958B.7050605@enterprise.bidmc.harvard.edu>
Date: Mon, 06 Dec 2004 12:23:23 -0500
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040919
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FS Corruption [Re: Linux 2.6.10-rc3]
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Ok, it's out there in all the normal places, and here's the shortlog for
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
rm: cannot remove `foo/include/asm-ppc/linkage.h': No such file or directory
rm: cannot remove `foo/include/asm-x86_64/rtc.h': No such file or directory
rm: cannot remove `foo/include/asm-m68knommu/mcftimer.h': No such file or directory
rm: cannot remove `foo/include/asm-m68k/linkage.h': No such file or directory
rm: cannot remove `foo/include/asm-sparc64/rwsem.h': No such file or directory
rm: cannot remove `foo/include/asm-sparc/psr.h': No such file or directory
[1]+  Exit 1                  rm -r foo
pinhead:/usr/src/kernels#


Running e2fsck on the next boot reports I've got a damaged filesystem.

System is a generic PC (a Dell GX110) - I810 chipset, PIII, IDE.  
Untainted vanilla kernel.  Other config details upon request.

Kris

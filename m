Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265019AbUELLkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbUELLkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 07:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUELLkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 07:40:52 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:50064 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265019AbUELLkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 07:40:49 -0400
Subject: Re: PROBLEM: compiling NTFS write support
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: andrea.fracasso@infoware-srl.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <27239.194.98.240.35.1084356865.squirrel@mail.infoware-srl.com>
References: <27239.194.98.240.35.1084356865.squirrel@mail.infoware-srl.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1084362026.16624.14.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 12:40:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-05-12 at 11:14, andrea.fracasso@infoware-srl.com wrote:
> Hi, I have found a problem compiling te source of kernel 2.6.6, if I
> enable NTFS write support when i run "make" i get this error:
> 
> ....
>   CC      fs/ntfs/inode.o
>   CC      fs/ntfs/logfile.o
> {standard input}: Assembler messages:
> {standard input}:683: Error: suffix or operands invalid for `bsf'
> make[2]: *** [fs/ntfs/logfile.o] Error 1
> make[1]: *** [fs/ntfs] Error 2
> make: *** [fs] Error 2
> 
> my kernel version is:
> Linux version 2.6.5-AS1500 (root@ntb-gozzolox) (gcc version 3.3.2 20031022
> (Red Hat Linux 3.3.2-1)) #3 Thu Apr 15 10:13:11 CEST 2004
> 
> my cpu is:
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 4
> model name      : AMD Athlon(tm) 64 Processor 3200+

Thanks for the report.  Yes, this has been reported already to me but I 
didn't get a response from the other person yet, so perhaps you could
help...  Note that this works fine on my P4 with SuSE Linux
(gcc-3.3.3-36 rpm and binutils 2.15.90.0.1.1-26 rpm) and it works fine
for many other people...

Which binutils version do you have (rpm -q binutils)?

Can you type (inside the configured kernel tree):

make fs/ntfs/logfile.s

And email this file to me.  Line 683 of that file should give us a clue
why this is failing.

Thanks a lot in advance.

Best regards,

	Anton

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/



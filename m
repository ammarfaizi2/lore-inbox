Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRKMIFl>; Tue, 13 Nov 2001 03:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281548AbRKMIFa>; Tue, 13 Nov 2001 03:05:30 -0500
Received: from maa3.cc.lut.fi ([157.24.8.133]:6668 "EHLO maa3.cc.lut.fi")
	by vger.kernel.org with ESMTP id <S281489AbRKMIFW>;
	Tue, 13 Nov 2001 03:05:22 -0500
Date: Tue, 13 Nov 2001 10:05:20 +0200 (EET)
From: Mika Yrjola <myrjola@lut.fi>
Reply-To: <myrjola@lut.fi>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/<pidnumber>/stat hangs reading process
Message-ID: <Pine.LNX.4.33.0111130947490.9769-100000@maa3.cc.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

basically this posting is about the same problem as one I posted in
September:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.0/0764.html

It's essentially the same situation: I was running mozilla and it stopped
responding to any input. I tried to kill it with control-c, kill and
finally with kill -9, but none helped. When I tried to look at the output
of top and ps, the exactly same symptons appeared; those processes didn't
finish and can't be killed either. When I do strace ps the output ends at:

stat64("/proc/16515", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/16515/stat", O_RDONLY)      = 7
read(7,

Kernel information at this time:

Linux renttu.lnet.lut.fi 2.4.12 #1 Wed Oct 17 20:09:21 EEST 2001 i686
unknown

(in September I was running 2.4.8)

Additional differences compared to the previous post:

- the machine has now 512 MB of DDR memory
- the /var/log/messages entry didn't appear this time, so I guess it was
probably something unrelated last time.

I'll keep the machine running until evening and upgrade to newer kernel
in case someone has any suggestions to try for getting more information
about the problem. Anyone knows if this problem is fixed in newer kernels?
(Any suggestions for the kernel to go - 2.4.13-ac, 2.4.14, 2.4.15-pre4 ?)

I've not subscribed to the list, because my mail traffic is already quite
overwhelming, so I appreciate if replies will be CC'ed to me, althought I
follow the list now and then with the archive on the web.

-- 
/-------------------------------------------------------------------------\
I Fantasy, Sci-fi, Linux, Amiga, Telecommunications, Oldfield, Vangelis    I
I Seti@Home, Steady relationship, more at http://www.lut.fi/%7emyrjola/    I
\-------------------------------------------------------------------------/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSHPV3M>; Fri, 16 Aug 2002 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSHPV3M>; Fri, 16 Aug 2002 17:29:12 -0400
Received: from smtp5.arnet.com.ar ([200.45.191.23]:32231 "HELO
	smtp5.arnet.com.ar") by vger.kernel.org with SMTP
	id <S318242AbSHPV3L>; Fri, 16 Aug 2002 17:29:11 -0400
Date: Fri, 16 Aug 2002 18:33:12 -0300
From: John Coppens <jcoppens@usa.net>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: proc/sys/fs file-nr?
Message-Id: <20020816183312.728a970a.jcoppens@usa.net>
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The last few days I had a problem with an image viewer, and thought I'd investigate
a little. The program makes thumbnails, and after a while, complains about
'too many files open'. I found a reference to the proc/sys/fs/file-max and
wanted to check file-nr first. /usr/src/linux/Documentation states:

"The three  values  in file-nr denote the number of allocated file handles, the
number of  used file handles, and the maximum number of file handles."

I'm confused now. Each time I open a new directory with images, the second number
_decreases_! It _increases_ when I close the viewer program. Is this normal?

Finally, the viewer (gThumb) gives up at: 

1961    50      8192

with the 'too many...' error. Shouldn't the number increase till 8192? This is
the number in file-max? (Kernel 2.4.18)

John

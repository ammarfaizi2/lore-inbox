Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbRCDBj7>; Sat, 3 Mar 2001 20:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRCDBjt>; Sat, 3 Mar 2001 20:39:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:25104 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129948AbRCDBjj>;
	Sat, 3 Mar 2001 20:39:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: sjhill@cotw.com
cc: linux-kernel@vger.kernel.org
Subject: Re: LILO error with 2.4.3-pre1... 
In-Reply-To: Your message of "Sat, 03 Mar 2001 19:19:28 MDT."
             <3AA19820.6A33E871@cotw.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Mar 2001 12:39:32 +1100
Message-ID: <22634.983669972@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Mar 2001 19:19:28 -0600, 
"Steven J. Hill" <sjhill@cotw.com> wrote:
>I have no idea why the 1023 limit is coming up considering 2.4.2 and
>LILO were working just fine together and I have a newer BIOS that has
>not problems detecting the driver properly. Go ahead, call me idiot :).

OK, you're an idiot :).  It only worked before because all the files
that lilo used just happened to be below cylinder 1024.  Your partition
goes past cyl 1024 and your new kernel is using space above 1024.  Find
a version of lilo that can cope with cyl >= 1024 (is there one?) or
move the kernel below cyl 1024.  You might need to repartition your
disk to get / all below 1024.


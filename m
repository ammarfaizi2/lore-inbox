Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSCYRRn>; Mon, 25 Mar 2002 12:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSCYRRf>; Mon, 25 Mar 2002 12:17:35 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:2556 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S312453AbSCYRRU>; Mon, 25 Mar 2002 12:17:20 -0500
Date: Mon, 25 Mar 2002 12:17:25 -0500
From: Grogan <grogan@pcnineoneone.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
Message-Id: <20020325121725.71f6df02.grogan@pcnineoneone.com>
In-Reply-To: <5.1.0.14.2.20020325013452.03e53630@pop.cus.cam.ac.uk>
Organization: PC911
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002 02:26:41 +0000
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> Please everyone courageous enough to use a bleeding edge kernel and who is 
> also an NTFS user give this a try and let me know if you encounter any 
> problems! - Thanks!

Hello everyone

   I have been lurking here for a while on and off (to read the interesting discussions and learn). Since I've got a Windows XP installation on an NTFS partition on one of my hard disks, I went and got the 2.5.7 source and applied this patch last night.

It compiled cleanly with gcc 2.95.3 and is considerably faster than any of the old NTFS drivers. Before, there was a bit of a CPU intensive delay browsing directories in a file manager, like system32 and i386 with alot of files when they have to be initially read from disk. The perceived difference between the driver in 2.4.19-pre4 is certainly noticable on an older system like this one. (PII @266 with 128 Mb RAM). I figured I'd best measure something here, so I tried a bit of a test.

Now, I realize this test is flawed because it also tests file creation and buffers and cache and everything between the two kernels but it sure shows that someone is on the right track, somewhere.

On a fresh boot with 2.4.19-pre4:

bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test

real    8m45.256s
user    0m0.730s
sys     6m27.030s

On a fresh boot with 2.5.7 with the new NTFS driver:

bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test

real    3m13.190s
user    0m0.610s
sys     0m51.660s

This "test" was repeated twice under the same conditions, with negligible difference in the result (couple of seconds). Both of these disks are on the same IDE controller (/home is /dev/hda8 and the NTFS partition is /dev/hdb2). I must say I wasn't expecting such a drastic difference. The data appears to be intact. (correct size and number of files, anyway)

I wanted to send  a "thumbs up". Thanks, Anton, and everyone else that does what they do around here : - )

Grogan

On Mon, 25 Mar 2002 02:26:41 +0000
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> Please everyone courageous enough to use a bleeding edge kernel and who is 
> also an NTFS user give this a try and let me know if you encounter any 
> problems! - Thanks!
> 
> Best regards,
> 
> Anton
> 
> 
>

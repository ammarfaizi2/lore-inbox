Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280623AbRKJM2i>; Sat, 10 Nov 2001 07:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280625AbRKJM22>; Sat, 10 Nov 2001 07:28:28 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:2312 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280623AbRKJM2T>; Sat, 10 Nov 2001 07:28:19 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Sat, 10 Nov 2001 12:28:21 +0000
From: quintaq@yahoo.co.uk
To: linux-kernel@vger.kernel.org
Subject: Problems creating filsystems and with dd
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20011110122822Z280623-17408+13011@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8th October I posted the following :

> I have just installed a Maxtor 30GB drive as /dev/hdc in my SuSE 7.0
> system which has a vanilla 2.4.10 kernel.  I found that I could write the
> partition table and create a small ext2 partition for /boot plus 768MB of
> swap.  Creation of the main ext2 filesystem on /hdc7 failed (before the
> inode tables even began to be written), with "file size limit exceeded".
> The same problem recurred every time I tried - and I did try various
> combinations of partition size.  I see the same error message when trying
> to change partition table flags.  The problem is identical using fdisk,
> cfdisk and parted.  I have no file limits set in ulimit and I do notthink
> that this is the problem. 
> 
> I eventually put the same drive as /dev/hdc in another box running a
stock
> SuSE 2.2.16 kernel and creation of the filesystems completed without any
> problem.  I have also verified this by booting this box using SuSE's
2.2.16 rescue kernel.
> 
> Any ideas?

Alan Cox responded :

>Obvious one to check would be to see if when 2.4.10 acquired the page
>cache changes someone backed out the device picks up underlying file size
limit >bug fix that the -ac tree has and went to Linus.

>It really sounds like that happened.

I have seen the same problem with subsequent kernels down to 2.4.14, which
I just installed.  I have also found the file size limit exceeded
error when trying to back up with dd if=/dev/hda1 of=/dev/hdc1 bs=16k,
where both partitions are 7.5 GB. Here again, I do not see the problem if I
revert to 2.2.16.

I was wondering (a) if the problems are related, and (b) whether a fix is
likely soon.

I am not subscribed, so a cc to me from any responder would be kind.

Thanks,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQKSMup>; Sun, 19 Nov 2000 07:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbQKSMug>; Sun, 19 Nov 2000 07:50:36 -0500
Received: from MailAndNews.com ([199.29.68.161]:6150 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S129226AbQKSMuV>;
	Sun, 19 Nov 2000 07:50:21 -0500
X-WM-Posted-At: MailAndNews.com; Sun, 19 Nov 00 07:20:08 -0500
X-WebMail-UserID: aer-list
Date: Sun, 19 Nov 2000 07:20:08 -0500
From: Anders Eriksson <aer-list@MailAndNews.com>
To: ebiederm@xmission.com (Eric W. Biederman),
        Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00000000
Subject: RE: [PATCH] swap=<device> kernel commandline
Message-ID: <3A1D09A9@MailAndNews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: InterChange (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>===== Original Message From ebiederm@xmission.com (Eric W. Biederman) =====
>Werner Almesberger <Werner.Almesberger@epfl.ch> writes:
>
>> Eric W. Biederman wrote:
>> > I have one that loads a second kernel over the network using dhcp
>> > to configure it's interface and tftp to fetch the image and boots
>> > that is only 20kb uncompressed....
>>
>> Neat ;-) My goal is actually not only size, but also to have a relatively
>> normal build environment, e.g. my example is with shared newlib, regular
>> ash, and - unfortunately rather wasteful - glibc's ld.so.
>>
>> But a tftp loader in 20kB is rather good. Now the next challenge is the
>> same thing with NFS. Then we can finally kill nfsroot ;-)
>
>Hmm. What does it take to mount an NFS partition?
>
>Anyway.  All I did was wrote a tiny libc that is just a bunch of
>wrappers for syscalls, and some string functions.  Then I just wrote
>a straight forward C program to do the job.  Except for my added
>kexec call I can compile with glibc :)
>
>Now if glibc wouldn't link in 200k of unused crap when you make a
>trivial static binary I'd much prefer to use it...
>
>Though I wish it was possible to have a ramfs preloader instead of
>initrd.  An initramfs would allow me to not even compile in the block
>device driver layer, and be more efficient.
>
A discussion on l-k two months ago revealed that someone actually had made a 
patch that took a tarball (masquaraded as an initrd image) and unpacked it 
into a ramfs. I've got the mail samewhere if you want it.

/Anders

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKQVMh>; Fri, 17 Nov 2000 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQKQVM2>; Fri, 17 Nov 2000 16:12:28 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:6 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129309AbQKQVMY>; Fri, 17 Nov 2000 16:12:24 -0500
Date: Fri, 17 Nov 2000 21:29:59 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: Andries.Brouwer@cwi.nl
Cc: aeb@veritas.com, torvalds@transmeta.com, emoenke@gwdg.de, eric@andante.org,
        koenig@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org,
        kobras@tat.physik.uni-tuebingen.de
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001117212959.A857@turtle.tat.physik.uni-tuebingen.de>
In-Reply-To: <UTC200011170026.BAA133349.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011170026.BAA133349.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Nov 17, 2000 at 01:26:02AM +0100
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Nov 17, Andries.Brouwer@cwi.nl wrote:

> > both 2.2.x and 2.4.x kernels can't read `real sky' CDs
> 
> Yes. 2.0.38 is OK. I just made a patch that seems to work.
> 
> Harald, could you try
> 	ftp.xx.kernel.org/.../people/aeb/linux-2.4.0test9-isofs-patch
> and report?

works -- sort of:(   I've tried both test9 and test10 with your patch
on a PPro200 with 128MB ram and I get the same effects both times:

directory listing seems to be possible (haven't checked data contents yet)
BUT if I try "du /cdrom/"  (either using real cdrom device or loopback mount
of my sample isofs image) there seems to be a huge memory leak !

first observation is that "du" is awfuly slow -- it takes ~90 secs real time
and ~60 system cpu secs to "du" through the first ~70 of 106 direcories, 
then the 128MB memory are almost used up and the systems starts to
swap heavily.  this meory doesn't get freed up even after umount/losetup -d
or whatever -- only reboot "helps"...


I'll attach log files showing output of "free", /proc/meminfo and
output of ALT-SYSREQ-M plus full "ps" output  for both -test9 and 
-test10 with your patch  in the situation when almost all memory 
is "gone" (du already killed).  hope this helps...



Harald
-- 
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^

--FL5UXtIhxfXey3p5
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="log-test9.gz"
Content-Transfer-Encoding: base64

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
FLQNHq5vyfg37K7z/PIqAAA=

--FL5UXtIhxfXey3p5
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="log-test10.gz"
Content-Transfer-Encoding: base64

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

--FL5UXtIhxfXey3p5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

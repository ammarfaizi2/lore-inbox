Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153857AbQCYNe4>; Sat, 25 Mar 2000 08:34:56 -0500
Received: by vger.rutgers.edu id <S153848AbQCYNer>; Sat, 25 Mar 2000 08:34:47 -0500
Received: from paris11-nas2-43-237.dial.proxad.net ([212.27.43.237]:2763 "HELO alienor.populi.vox") by vger.rutgers.edu with SMTP id <S153680AbQCYNeW>; Sat, 25 Mar 2000 08:34:22 -0500
Date: Sat, 25 Mar 2000 10:49:19 +0100
From: Thierry Danis <danis@mail.dotcom.fr>
To: linux-kernel@vger.rutgers.edu
Subject: Very low cpio tansfer rates with 2.2.12-20
Message-ID: <20000325104918.A16983@alienor.populi.vox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
Sender: owner-linux-kernel@vger.rutgers.edu


Hello,

I needed to transfer a news spool tree (almost 650.000 files) between
two computers. I did that using a cpio through the network.

The command was :
# cd /var/spool
# find news -depth | cpio -oB | rsh other_computer 'cd /var/spool; cpio -iBdm'

As soon as I had to much files in some directories (say, more than 3000,
maybe less), the cpio paused 10 or 15 seconds every 100 files, with no
network load, no disk access, and no CPU load as well.
When in directories with few files, or at the beginning of a directory,
the transfer went back to normal.

It tooks hours to transfer all the spool tree, and the source computer
had a very low average load.

Both machines are RH 6.1 Stock RH kernel 2.2.12-20. Hard drives are 4 Go
UW SCSI. The source machine is a P100, 48Mb RAM, NE2000 PCI 10 Mb/s.
The destination machine is a Celeron 400, 64 Mb RAM, SMC 100 Mb/s.

The question is why was the machine almost idle during the transfer ?

A+,
-- 
	Thierry Danis
# rm *;o
o : commande non trouvée

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

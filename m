Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAWP7z>; Tue, 23 Jan 2001 10:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRAWP7p>; Tue, 23 Jan 2001 10:59:45 -0500
Received: from popeye.ipv6.univ-nantes.fr ([193.52.101.20]:269 "HELO
	popeye.ipv6.univ-nantes.fr") by vger.kernel.org with SMTP
	id <S129561AbRAWP7i>; Tue, 23 Jan 2001 10:59:38 -0500
Subject: __alloc_pages: 3-order allocation failed. for 2.4.1-pre9
From: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 23 Jan 2001 16:59:35 +0100
Mime-Version: 1.0
Message-Id: <20010123155935.552E9635@popeye.ipv6.univ-nantes.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had thoses errors messages on 2.4.1-pre9 :

__alloc_pages: 2-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
(ad nauseum)

I was doing backups on scsi streamers using tar ;

The files are on a md0 array, file system is reiserfs;

the machine has 128MB RAM, Swap is 512MB and was pratically unused ;

the tar then failed miserably -But the system was OK after that; 
Please note that this was after an hour or so of backup... 
And that I was doing 2 backups in the same time ...

The machine is an old pentium pro 200,
the scsi cards are Buslogic BT958 ( I have 3 of them ; 3x9 Gb on 1, 3x9b
on 2, 2 scsi tape on 3)

I remember sawing that those errors were due to improperly written
drivers . Is the buslogic driver or tape driver are to blame here ?? Or
maybe this is a vm balancing issue ?

Side note : Free gives this :

admin@dumbo:~$ free
             total       used       free     shared    buffers
cached
Mem:        126592     122856       3736          0     100968
8960
-/+ buffers/cache:      12928     113664
Swap:       522104       2352     519752

As we can expect, buffers are large, maybe a little too much ?

Yann Dupont.

-- 
\|/ ____ \|/ Fac. des sciences de Nantes-Linux-Python-IPv6-ATM-BONOM....
"@'/ ,. \@"  Tel :(+33) [0]251125865(AM)[0]251125857(PM)[0]251125868(Fax)
/_| \__/ |_\ Yann.Dupont@sciences.univ-nantes.fr
   \__U_/    http://www.unantes.univ-nantes.fr/~dupont

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

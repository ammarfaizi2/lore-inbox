Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbSJLKAs>; Sat, 12 Oct 2002 06:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJLKAs>; Sat, 12 Oct 2002 06:00:48 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:41480 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S262873AbSJLKAr> convert rfc822-to-8bit;
	Sat, 12 Oct 2002 06:00:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: How does ide-scsi get loaded?
Date: Sat, 12 Oct 2002 11:06:52 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210121106.58559.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Please cc me on replies as I am not subscribed to the list.

I am running a standard debian 2.4.19-k7 kernel on a configuration that has an 
ide dvd rom drive and a scsi cd writer.

Sometime during boot sequence (I can't find where in any log or dmesg - but 
looking at the text flying by - soon after the scsi adapter is found and the 
bus is being scanned for scsi devices) the module ide-scsi gets loaded.

The problem is, I don't want it loaded because it prevents mplayer playing my 
dvds

I initially assumed it was something in the debian start up that caused it but

a) asking on the debian-user mailing list has not elicited any useful reponse
b) grep -r ide-scsi /etc throws up nothing (ie there is not reference to 
ide-scsi in modules or modules.conf or any initialisation sequence doing a 
modprobe ide-scsi)
c) scanning all through the initrd.img (loaded through the loop device) does 
not show any reference to ide-scsi either (although grep finds the sequence 
in bin/mount and then hangs locking my keyboard)
d) modules.dep only shows ide-scsi needing other modules (ide-mod, scsi-mod) 
not the other way round.

I am stuck, where can I look next?

[and I know I could just do a rmmod at the end of the start up sequence but 
...]
- -- 
Alan Chandler
alan@chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9p/RCuFHxcV2FFoIRAiqmAJ4y7pWivbaNV/L4LKqLyBYpu+VsUgCgnSK2
5YnCzrh6yVM+iwnBVk1BZQE=
=N3vq
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135367AbRDLWXr>; Thu, 12 Apr 2001 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135366AbRDLWXi>; Thu, 12 Apr 2001 18:23:38 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:31432 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S135367AbRDLWXe>; Thu, 12 Apr 2001 18:23:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Unable to use ethernet after suspend and smbmount (laptop)
From: burton@relativity.yi.org (Kevin A. Burton)
Date: 12 Apr 2001 14:53:26 -0700
Message-ID: <m3bsq1dbu1.fsf@relativity.yi.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


OK.

This is Kernel 2.4.3.

If I smbmount an exported filesystem from another GNU/Linux machine and then
suspend my laptop, after I resume I am unable to use the network at all.

I really think this is a bug raised by another bug.  The xirc2ps_cs Ethernet Cardbus
driver has a bug where after a suspend I have to eject the card and then insert
it again and then run 'ifup eth0'.  I think it actually may be a bug in my
cardbus but I don't know.

Anyway Linux won't unload (rmmod xirc2ps_cs) because the smbfs is using it.  :(
If force smbfs to unmount maybe this could be resolved but as we all know an
'umount -f /mnt/MOUNT' doesn't really force :(

Anyway.  If anyone has any suggestions I would appreciate it.  If I unmount
*before* I suspend then everything works fine.  The problem is that sometimes I
forget! :(

Kevin

- -- 
Kevin A. Burton ( burton@apache.org, burton@openprivacy.org, burtonator@acm.org )
        Cell: 408-910-6145 URL: http://relativity.yi.org ICQ: 73488596 

You may say I'm a dreamer, but I'm not the only one. - John Lennon



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Get my public key at: http://relativity.yi.org/pgpkey.txt

iD8DBQE61iPWAwM6xb2dfE0RAvXwAJ9/NdkCXuX5jXPUpPAp/9iGOtrvMgCgzMho
DmYqTqZmZnk3YrXuwqnPwWE=
=4vhk
-----END PGP SIGNATURE-----


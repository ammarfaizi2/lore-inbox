Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRK0WZB>; Tue, 27 Nov 2001 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281794AbRK0WYv>; Tue, 27 Nov 2001 17:24:51 -0500
Received: from det-laptop.ilan.net ([216.27.3.69]:24706 "EHLO
	det-laptop.ilan.net") by vger.kernel.org with ESMTP
	id <S276369AbRK0WYj>; Tue, 27 Nov 2001 17:24:39 -0500
Message-ID: <3C041272.5070401@springboardhosting.com>
Date: Tue, 27 Nov 2001 17:23:46 -0500
From: Duane Toler <dtoler@springboardhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre2: ipv6 module compile fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

browsing through the archives i notice others are having problems with 2.5.1-pre2.
here are my results:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.0/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.0/include/linux/modversions.h   -c -o ndisc.o ndisc.c
{standard input}: Assembler messages:
{standard input}:821: Error: bad register name `%edxadcl 4(%ebp)'
{standard input}:1024: Error: bad register name `%ecxadcl 4(%edx)'
{standard input}:1186: Error: bad register name `%ecxadcl 4(%edx)'
{standard input}:2272: Error: bad register name `%ecxadcl 4(%esi)'
make[2]: *** [ndisc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.0/net/ipv6'
make[1]: *** [_modsubdir_ipv6] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.0/net'
make: *** [_mod_net] Error 2

patch was applied as `bzip2 -dc patch-2.5.1-pre2.bz2| patch -p0` to a clean 2.5.0 tree.

root@wolf:/usr/src/linux# cc -v
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

i am not subscribed to the list but i read the archives on marc.theaimsgroup.com frequently.

thanks!

- --
Duane Toler  -  dtoler@springboardmsp.com
Springboard Managed Hosting
Cisco Certified Network Associate (CCNA)
Checkpoint Certified Security Administrator (CCSA)
Certified Linux Administrator
PGP key available upon request

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQEVAwUBPAQSVoLwy5I5v/BTAQENjAf/fsYFb2QW+S6fpX8WtKCS8VuCu2g0HTjK
Q5n7RBgIgYhF1k8zDhIuxl7imWdMxsqVnq12htK4Lp0dvFfCcpp4fCwuSNMcb5CM
unpFMWmdIlP1aC1jhSKaiBL9jadTbYpm2igrtB1SONFh6t5WLMRbC9I4IyLPHMsY
ekJUzcZbXYWcWUcM/9WQKQNlQPPsar2Bs07wafDl6nclYvtVqeiWkG7eMBZxdjfz
5P4gGwMF1uDjav9TIHizFJe9W9JFiatr765227DZMyDUdCHl6EvWedkmKmZwATcl
A/2ohBRafwOnulXNzE+gKHOWoY7+E7AGmeI7smRmJcFKSThBSs9VTA==
=DOEG
-----END PGP SIGNATURE-----


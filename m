Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUGFQtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUGFQtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUGFQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:49:23 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:1664 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S264153AbUGFQso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:48:44 -0400
Date: Tue, 6 Jul 2004 09:48:39 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040706164839.GA1094@tumblerings.org>
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com> <1089054464.15675.56.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089054464.15675.56.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Mon, Jul 05, 2004 at 03:07:44PM -0400, Len Brown wrote:
> On Sat, 2004-07-03 at 22:05, Zack Brown wrote:
> > Hi folks,
> > 
> > When booting vanilla 2.4.26 with SMP enabled, I get a lockup before
> > the
> > boot sequence is completed. The same kernel with SMP disabled boots
> > and runs
> > just fine. Both CPUs are detected by the system at bootup, before lilo
> > takes
> > over. Here's the error as I wrote it down from the screen, followed by
> > the
> > .config file:
> e 
> > ------------------------------ cut here ------------------------------
> > Using local APIC timer interrupts.
> > Calibrating APIC timer...
> > ..... CPU clock speed is 1004.4785 MHZ
> > ..... hostbus clock speed is 133.9304 MHz
> > cpu: 0, clocks: 1339304, slice: 446434
> > CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> > cpu: 1, clocks: 1339304, slice: 446434
> > CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> > ------------------------------ cut here ------------------------------
> 
> complete dmesg from success case would help,
> but try booting with "acpi=off", as that will
> disable ACPI for CPU enumeration, and if there
> is a bug in your ACPI tables, it would avoid it.

I tried acpi=off, and got a hang at boot right after the line:

CPU0<T0:1339376,T1:892912,D:4,S:446460,C:1339380

To get dmesg output from a success case, I booted using the 'noapic' boot
option, which successfully boots the same 2.4.26 SMP kernel, but gives problems
when actually trying to use both CPUs (the 'crafty' chess engine hangs as soon
as it forks), so here is my 'dmesg' output from that. I'm not sure if that's
the kind of success case you want, so let me know what else I should post.

Be well,
Zack


------------------------------ cut here ------------------------------
test 3 (64 bit key):
690f5b0d9a26939b
pass
test 4 (64 bit key):
c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
pass
test 5 (64 bit key):
setkey() failed flags=100100
c95744256a5ed31d
pass

testing des ECB encryption across pages (chunking) 
test 1 (64 bit key):
page 0
c95744256a5ed31d
pass
page 1
f79c892a338f4a8b
pass
test 2 (64 bit key):
page 0
c95744256a5ed31df79c892a338f
pass
page 1
4a8bb49926f71fe1d490
pass
page 2
f79c892a338f4a8b
pass
test 3 (64 bit key):
page 0
c957
pass
page 1
44
pass
page 2
256a5e
pass
page 3
d31df79c892a338f4a8bb49926f71fe1d490
pass
test 4 (64 bit key):
page 0
c957
pass
page 1
4425
pass
page 2
6a5e
pass
page 3
d31d
pass
page 4
f79c892a338f4a8b
pass
test 5 (64 bit key):
page 0
c9
pass
page 1
57
pass
page 2
44
pass
page 3
25
pass
page 4
6a
pass
page 5
5e
pass
page 6
d3
pass
page 7
1d
pass

testing des ECB decryption 
test 1 (64 bit key):
0123456789abcde7
pass
test 2 (64 bit key):
01a1d6d039776742
pass

testing des ECB decryption across pages (chunking) 
test 1 (64 bit key):
page 0
0123456789abcde7
pass
page 1
a3997bcaaf69a0f5
pass
test 2 (64 bit key):
page 0
012345
pass
page 1
6789abcde7a3997bcaaf69a0
pass
page 2
f5
pass

testing des CBC encryption 
test 1 (64 bit key):
ccd173ffab2039f4acd8aefddfd8a1eb468e91157888ba68
pass
test 2 (64 bit key):
e5c7cdde872bf27c
pass
test 3 (64 bit key):
43e934008c389c0f
pass
test 4 (64 bit key):
683788499a7c05f6
pass

testing des CBC encryption across pages (chunking) 
test 1 (64 bit key):
page 0
ccd173ffab2039f4acd8aefddf
pass
page 1
d8a1eb468e91157888ba68
pass

testing des CBC decryption 
test 1 (64 bit key):
4e6f772069732074
pass
test 2 (64 bit key):
68652074696d6520
pass
test 3 (64 bit key):
666f7220616c6c20
pass

testing des CBC decryption across pages (chunking) 
test 1 (64 bit key):
page 0
666f7220
pass
page 1
616c6c20
pass

testing des3_ede ECB encryption 
test 1 (192 bit key):
18d748e563620572
pass
test 2 (192 bit key):
c07d2a0fa566fa30
pass
test 3 (192 bit key):
e1ef62c332fe825b
pass

testing des3_ede ECB encryption across pages (chunking) 

testing des3_ede ECB decryption 
test 1 (192 bit key):
736f6d6564617461
pass
test 2 (192 bit key):
7371756967676c65
pass
test 3 (192 bit key):
0000000000000000
pass

testing des3_ede ECB decryption across pages (chunking) 

testing md4
test 1:
31d6cfe0d16ae931b73c59d7e0c089c0
pass
test 2:
bde52cb31de33e46245e05fbdbd6fb24
pass
test 3:
a448017aaf21d8525fc10ae87aa6729d
pass
test 4:
d9130a8164549fe818874806e1c7014b
pass
test 5:
d79e1c308aa5bbcdeea8ed63df412da9
pass
test 6:
043f8582f241db351ce627e153e7f0e4
pass
test 7:
e33b4ddc9c38f2199c3e7b164fcc0536
pass
testing md4 across pages
test 1:
d79e1c308aa5bbcdeea8ed63df412da9
pass

testing sha256
test 1:
ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
pass
test 2:
248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
pass
testing sha256 across pages
test 1:
248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1
pass

testing blowfish ECB encryption 
test 1 (64 bit key):
4ef997456198dd78
pass
test 2 (64 bit key):
a790795108ea3cae
pass
test 3 (64 bit key):
e87a244e2cc85e82
pass
test 4 (128 bit key):
93142887ee3be15c
pass
test 5 (168 bit key):
e6f51ed79b9db21f
pass
test 6 (448 bit key):
c04504012e4e1f53
pass

testing blowfish ECB encryption across pages (chunking) 

testing blowfish ECB decryption 
test 1 (64 bit key):
0000000000000000
pass
test 2 (64 bit key):
0123456789abcdef
pass
test 3 (64 bit key):
fedcba9876543210
pass
test 4 (128 bit key):
fedcba9876543210
pass
test 5 (168 bit key):
fedcba9876543210
pass
test 6 (448 bit key):
fedcba9876543210
pass

testing blowfish ECB decryption across pages (chunking) 

testing blowfish CBC encryption 
test 1 (128 bit key):
6b77b4d63006dee605b156e27403979358deb9e7154616d959f1652bd5ff92cc
pass

testing blowfish CBC encryption across pages (chunking) 

testing blowfish CBC decryption 
test 1 (128 bit key):
37363534333231204e6f77206973207468652074696d6520666f722000000000
pass

testing blowfish CBC decryption across pages (chunking) 

testing twofish ECB encryption 
test 1 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35a
pass
test 2 (192 bit key):
cfd1d2e5a9be9cdf501f13b892bd2248
pass
test 3 (256 bit key):
37527be0052334b89f0cfccae87cfa20
pass

testing twofish ECB encryption across pages (chunking) 

testing twofish ECB decryption 
test 1 (128 bit key):
00000000000000000000000000000000
pass
test 2 (192 bit key):
00000000000000000000000000000000
pass
test 3 (256 bit key):
00000000000000000000000000000000
pass

testing twofish ECB decryption across pages (chunking) 

testing twofish CBC encryption 
test 1 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35a
pass
test 2 (128 bit key):
d491db16e7b1c39e86cb086b789f5419
pass
test 3 (128 bit key):
05ef8c61a811582634ba5cb7106aa641
pass
test 4 (128 bit key):
9f589f5cf6122c32b6bfec2f2ae8c35ad491db16e7b1c39e86cb086b789f541905ef8c61a811582634ba5cb7106aa641
pass

testing twofish CBC encryption across pages (chunking) 

testing twofish CBC decryption 
test 1 (128 bit key):
00000000000000000000000000000000
pass
test 2 (128 bit key):
00000000000000000000000000000000
pass
test 3 (128 bit key):
00000000000000000000000000000000
pass
test 4 (128 bit key):
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
pass

testing twofish CBC decryption across pages (chunking) 

testing serpent ECB encryption 
test 1 (0 bit key):
1207fcce9bd0d6476ae98fbed143a0e2
pass
test 2 (128 bit key):
4c7d8a328072a22c823e4a1f3acda16d
pass
test 3 (256 bit key):
de269ff833e432b85b2e88d2701ce75c
pass
test 4 (128 bit key):
ddd26b98a5ffd82c05345a9dadbfaf49
pass

testing serpent ECB encryption across pages (chunking) 

testing serpent ECB decryption 
test 1 (0 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 2 (128 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 3 (256 bit key):
000102030405060708090a0b0c0d0e0f
pass
test 4 (128 bit key):
00000000000000000000000000000000
pass

testing serpent ECB decryption across pages (chunking) 

testing aes ECB encryption 
test 1 (128 bit key):
69c4e0d86a7b0430d8cdb78070b4c55a
pass
test 2 (192 bit key):
dda97ca4864cdfe06eaf70a0ec0d7191
pass
test 3 (256 bit key):
8ea2b7ca516745bfeafc49904b496089
pass

testing aes ECB encryption across pages (chunking) 

testing aes ECB decryption 
test 1 (128 bit key):
00112233445566778899aabbccddeeff
pass
test 2 (192 bit key):
00112233445566778899aabbccddeeff
pass
test 3 (256 bit key):
00112233445566778899aabbccddeeff
pass

testing aes ECB decryption across pages (chunking) 

testing cast5 ECB encryption 
test 1 (128 bit key):
238b4fe5847e44b2
pass
test 2 (80 bit key):
eb6a711a2c02271b
pass
test 3 (40 bit key):
7ac816d16e9b302e
pass

testing cast5 ECB encryption across pages (chunking) 

testing cast5 ECB decryption 
test 1 (128 bit key):
0123456789abcdef
pass
test 2 (80 bit key):
0123456789abcdef
pass
test 3 (40 bit key):
0123456789abcdef
pass

testing cast5 ECB decryption across pages (chunking) 

testing cast6 ECB encryption 
test 1 (128 bit key):
c842a08972b43d20836c91d1b7530f6b
pass
test 2 (192 bit key):
1b386c0210dcadcbdd0e41aa08a7a7e8
pass
test 3 (256 bit key):
4f6a2038286897b9c9870136553317fa
pass

testing cast6 ECB encryption across pages (chunking) 

testing cast6 ECB decryption 
test 1 (128 bit key):
00000000000000000000000000000000
pass
test 2 (192 bit key):
00000000000000000000000000000000
pass
test 3 (256 bit key):
00000000000000000000000000000000
pass

testing cast6 ECB decryption across pages (chunking) 

testing arc4 ECB encryption 
test 1 (64 bit key):
75b7878099e0c596
pass
test 2 (64 bit key):
7494c2e7104b0879
pass
test 3 (64 bit key):
de188941a3375d3a
pass
test 4 (32 bit key):
d6a141a7ec3c38dfbd615a1162e1c7ba36b67858
pass
test 5 (64 bit key):
66a0949f8af7d6891f7f832ba833c00c892ebe30143ce28740011ecf
pass
test 6 (32 bit key):
d6a141a7ec3c38dfbd61
pass
test 7 (128 bit key):
697236591b5242b1
pass

testing arc4 ECB encryption across pages (chunking) 

testing arc4 ECB decryption 
test 1 (64 bit key):
0123456789abcdef
pass
test 2 (64 bit key):
0000000000000000
pass
test 3 (64 bit key):
0000000000000000
pass
test 4 (32 bit key):
0000000000000000000000000000000000000000
pass
test 5 (64 bit key):
123456789abcdef0123456789abcdef0123456789abcdef012345678
pass
test 6 (32 bit key):
00000000000000000000
pass
test 7 (128 bit key):
0123456789abcdef
pass

testing arc4 ECB decryption across pages (chunking) 

testing sha384
test 1:
cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
pass
test 2:
3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
pass
test 3:
09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
pass
test 4:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass
testing sha384 across pages
test 1:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass

testing sha512
test 1:
ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
pass
test 2:
204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
pass
test 3:
8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
pass
test 4:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass
testing sha512 across pages
test 1:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass

testing deflate compression
test 1:
f3cacfcc53282d56c8cb2f5748cc4b5128ce482c4a5528c9485528ce4f2b290771bc082b0100
pass (ratio 70:38)
test 2:
5d8d310ec2301004bfb22fc81f10040989c2853f70b12ff824db67d947c1ef49681251ae7667d62719881ade85ab21f2085d161e20042dadf318a215852d69c4428323b66c89719befcf8b9fcf33ca2fed62a94c80ff13af5237ed0e526b5902d94ee87a761d0298fe8a8783a34f568ab89e8e5c57d3a079fa02
pass (ratio 191:122)

testing deflate decompression
test 1:
5468697320646f63756d656e7420646573637269626573206120636f6d7072657373696f6e206d6574686f64206261736564206f6e20746865204445464c415445636f6d7072657373696f6e20616c676f726974686d2e20205468697320646f63756d656e7420646566696e657320746865206170706c69636174696f6e206f6620746865204445464c41544520616c676f726974686d20746f20746865204950205061796c6f616420436f6d7072657373696f6e2050726f746f636f6c2e
pass (ratio 122:191)
test 2:
4a6f696e207573206e6f7720616e642073686172652074686520736f667477617265204a6f696e207573206e6f7720616e642073686172652074686520736f66747761726520
pass (ratio 38:70)

testing hmac_md5
test 1:
9294727a3638bb1c13f48ef8158bfc9d
pass
test 2:
750c783e6ab0b503eaa86e310a5db738
pass
test 3:
56be34521d144c88dbb8c733f0e8b3f6
pass
test 4:
697eaf0aca3a3aea3a75164746ffaa79
pass
test 5:
56461ef2342edc00f9bab995690efd4c
pass
test 6:
6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
pass
test 7:
6f630fad67cda0ee1fb1f562db3aa53e
pass

testing hmac_md5 across pages
test 1:
750c783e6ab0b503eaa86e310a5db738
pass

testing hmac_sha1
test 1:
b617318655057264e28bc0b6fb378c8ef146be00
pass
test 2:
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass
test 3:
125d7342b9ac11cd91a39af48aa17b4f63f175d3
pass
test 4:
4c9007f4026250c6bc8414f9bf50c86c2d7235da
pass
test 5:
4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
pass
test 6:
aa4ae5e15272d00e95705637ce8a3b55ed402112
pass
test 7:
e8e99d0f45237d786d6bbaa7965c7808bbff1a91
pass

testing hmac_sha1 across pages
test 1:
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass

testing hmac_sha256
test 1:
a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
pass
test 2:
104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
pass
test 3:
470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
pass
test 4:
198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
pass
test 5:
5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
pass
test 6:
cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
pass
test 7:
d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
pass
test 8:
7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
pass
test 9:
6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
pass
test 10:
6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
pass

testing hmac_sha256 across pages
test 1:
5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
pass
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
hub.c: new USB device 00:04.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x4b8/0x11b) is not claimed by any active driver.
Adding Swap: 307192k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting half-duplex based on MII#1 link partner capability of 40a1.
eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
------------------------------ cut here ------------------------------

> 
> -Len
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown

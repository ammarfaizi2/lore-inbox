Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280554AbRKNMn6>; Wed, 14 Nov 2001 07:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280556AbRKNMnj>; Wed, 14 Nov 2001 07:43:39 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:14420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280554AbRKNMn3> convert rfc822-to-8bit;
	Wed, 14 Nov 2001 07:43:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [VM] 2.4.14/15-pre4 too "swap-happy"?
Date: Wed, 14 Nov 2001 13:44:43 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011114124337Z280554-17408+14330@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
Are there any paramters (for example in /proc/sys/vm), which make the VM less 
swap-happy?
My problems are following:

I burn a CD-R on system 1:
...
- ---Swap: 0 KB
mkisofs blablabla
- ---swap begins to rise ;)
mkisofs finished
- ---swap: 3402 KB
cdrecord speed=12 blablabla (FIFO is 4 MB)
- ---heavy swapping
cdrecord finished
- ---swap: 27421 KB

The system has 256 MB RAM, nothing RAM-eating in the background I got many 
buffer-underuns just because of swapping. When I turn swap off everything 
works fine. I think it's something with the cache.

Leaving system 2 alone, just play mp3s over nfs:

After two or three days the used swap-space is around 3 MB. I just played 
MP3s and no X and no other "big" applications were running. This isn't really 
a problem but it doesn't look good. Just because of cache swap gets full :(

I think this must be fixed before opening 2.5.
It isn't good when something gets swapped out just because of the cache. 
It'll be better if the cache gets lesser priority.

system 1:
Kernel 2.4.15-pre4
Intel Pentium II @ 350 MHZ
256 MB RAM
512 MB Swap

system 2:
Kernel 2.4.14
AMD K6-2 @ 350 MHZ
128 MB RAM
256 MB Swap

If you need some more system information contact me and I'll post them
I'll be happy to test all your patches/suggestions :)

Thanks in advance
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78mc+vIHrJes3kVIRAhooAJ4mp52iyrIkRPe/wicwrSxmIwmvYQCgg/NQ
MW522KOtGdhPdjRVbXwLrko=
=TlFS
-----END PGP SIGNATURE-----

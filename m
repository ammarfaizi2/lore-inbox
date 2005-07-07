Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVGGIlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGGIlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGGIll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:41:41 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:59798 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261248AbVGGIlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:41:25 -0400
Message-ID: <42CCEAA7.1010807@grimmer.com>
Date: Thu, 07 Jul 2005 10:41:11 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
References: <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
In-Reply-To: <20050707080323.GF1823@suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Jens Axboe wrote:

> ATA7 defines a park maneuvre, I don't know how well supported it is 
> yet though. You can test with this little app, if it says 'head 
> parked' it works. If not, it has just idled the drive.

Great! Thanks for digging this up - it works on my T42, using a Fujitsu
MHT2080AH drive:

  lenz@metis:~/work/ibm_hdaps> sudo ./headpark /dev/hda
  head parked

Judging from the sound the drive makes, this is the same operation that
the windows tool performs.

However, the head does not remain parked for a very long time,
especially if there is a lot of disk activity going on (I tested it by
running a "find /" in parallel). The head parks, but leaves the park
position immediately afterwards again. I guess now we need to find a way
to "nail" the head into the parking position for some time - otherwise
it may already be on its way back to the platter before the laptop hits
the ground...

Thanks again - this is another helpful bit in getting all the pieces
together.

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCzOqlSVDhKrJykfIRAlm0AJ9WvadtsxAdLdTCe40N/KDbvSLf5wCdEWWA
OsiXzwFjziNuKvK5HKSMjb4=
=qXXH
-----END PGP SIGNATURE-----

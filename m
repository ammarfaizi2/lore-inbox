Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUIDNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUIDNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUIDNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:48:16 -0400
Received: from cpe.atm0-0-0-2421032.0x3ef2dbfa.arcnxx7.customer.tele.dk ([62.242.219.250]:48766
	"EHLO host.kl-teknik.com") by vger.kernel.org with ESMTP
	id S263003AbUIDNr6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:47:58 -0400
From: Frederik Dannemare <frederik@dannemare.net>
To: Richard Whittaker <rwhittaker@northwestel.ca>
Subject: Re: Linux 2.6.8 SegFaulting...
Date: Sat, 4 Sep 2004 15:52:28 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <4137FC68.3010404@northwestel.ca>
In-Reply-To: <4137FC68.3010404@northwestel.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200409041552.29448.frederik@dannemare.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 03 September 2004 07:08, Richard Whittaker wrote:
> Hiya..
>
> We have a Proliant DL360 G3 running Linux 2.6.8. This machine has two
> CPUs, 3GB of memory, a pair of 146GB disks on the SmartArray 5i
> contoller, a QL2314 Fibrechannel card, and is using abou 60GB on an
> HP VA7400 via the Fibrechannel card. Under 2.6.6 and 1GB of memory
> this machine had run for 4 months without even a hiccup... As of
> yesterday, I added the space on the VA, and moved our MRTG monitoring
> system to the machine. Our MRTG currently monitors about 300
> different elements, and is pretty I/O intensive. The website that the
> MRTG graphs are being written to is on the VA.
>
> This machine crashed and burned in spectacular fashion last night for
> the first time in 4 months, and I was really suprised. The machine
> SegFaulted, but I couldn't get a capture of the stack spew... I had
> to power the machine off, and restart it this morning. The machine
> ran for about 4 hours, then SegFaulted again... I was able to at
> least see the Segfault info, and it was saying something about
> swapper. Power cycled, and about 5 hours later, Segfaulted again, but
> this time I was able to capture the DMESG output... I thought it
> might have been the software RAID device I'd made out of the two LUNS
> on the VA, but after wiping the LUNS out, and rebuilding them, and
> moving to LVM with striping the problem still persists.
>
> Everything in this Kernel is statically linked, and everything is
> stock, right from ftp.kernel.org...
>
> Now, I have a feeling that this has something to do with the I/O that
> I'm loading on the QLogic controller, but can't be absolutely
> certain... I pose the question here for perusal by the experts, and
> hopefully some suggestions about what I should look at, or do next...
[snip]
Can you rule out bad memory (try memtest86+ for 10-20 hours)? Or could 
it be heat? Bad mem and heat problems have been the source of almost 
all crashes I've witnessed.
- -- 
Frederik Dannemare | mailto:frederik@dannemare.net
http://qa.debian.org/developer.php?login=Frederik+Dannemare
http://frederik.dannemare.net | http://www.linuxworlddomination.dk
Key fingerprint: BB7B 078A 0DBF 7663 180A  F84A 2D25 FAD5 9C4E B5A8
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBOcicLSX61ZxOtagRAqyNAKCIlPOdU5Je7NSerF2NcD4qxNzlUQCgi1o2
plUHzPPGixdMT5ULZayszgQ=
=VvlJ
-----END PGP SIGNATURE-----

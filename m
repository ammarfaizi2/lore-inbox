Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWIYMRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWIYMRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIYMRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:17:18 -0400
Received: from mail.fampeeters.com ([195.64.89.135]:49305 "EHLO
	server2b.fampeeters.com") by vger.kernel.org with ESMTP
	id S1751129AbWIYMRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:17:15 -0400
Message-ID: <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
In-Reply-To: <877izsp3dm.fsf@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
Date: Mon, 25 Sep 2006 14:17:13 +0200 (CEST)
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: "Francesco Peeters" <Francesco@FamPeeters.com>
To: "Dominique Dumont" <domi.dumont@free.fr>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "alsa-user" <alsa-user@lists.sourceforge.net>
User-Agent: SquirrelMail/1.4.6-4.fc2.1.legacy
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, September 25, 2006 13:55, Dominique Dumont wrote:
>
> Hello
>
> I have some problem using the SPDIF output of my SB Live card while
> performing I/O on my SATA drive. (See [1] for the whole story on the
> ALSA mailing list)
>
> My Yamaha amplifier does not recognize the AC3 (Dolby digital) stream
> from the sdpif plug while performing I/O on my SATA drive.
>
> If I have a lot of I/O (e.g. running md5sum on a 4Gb file), the AC3
> stream is completely broken.
>
> If I have some I/O (e.g. reading a Hi-def movie), I get some AC3
> drop-out even if the CPU is about 50%.
>
> I have the same result with DTS output.
>
> With PCM output, I've noticed a hi-frequency distortion, which means
> that the interaction between SATA and snd module occurs several
> thousands time per second.
>
> My set up is:
> - Debian Linux kernel 2.6.17
> - Sound blaster SB Live 5.1 (snd_emu10k1 module)
> - SATA drive (sata_sil and libata module)
> - A7n8x deluxe mobo
> - AMD XP 3200
>
> So far I verified that:
> - AC3 output works fine when SATA drive is left alone
> - AC3 output works fine when running md5sum on a PATA drive
> - DTS output works fine on the mobo SPDIF output (snd_intel8x0 module)
>   even when running md5sum on the SATA drive. (cannot try AC3 stream
>   because of Soundstorm chip :-( )
> - Preemp kernel option does not fix the problem
> - when running md5sum on SATA drive, alsa driver report a starvation
>   (xrun) every few seconds, not thousands of time per second.
>
> Could someone shed some light on this problem ?
>
> What can I do to help debug this problem ?
>
> Thanks
>
>

Have you tried using a different slot for the SB Live?

-- 
Francesco Peeters
----
GPG Key = AA69 E7C6 1D8A F148 160C  D5C4 9943 6E38 D5E3 7704
If your program doesn't recognize my signature, please visit
http://www.CAcert.org/index.php?id=3 to retrieve the Root CA certificate.

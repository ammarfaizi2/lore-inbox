Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbQLIMD0>; Sat, 9 Dec 2000 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbQLIMDQ>; Sat, 9 Dec 2000 07:03:16 -0500
Received: from smtp5.libero.it ([193.70.192.55]:31721 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S131474AbQLIMDK>;
	Sat, 9 Dec 2000 07:03:10 -0500
Message-ID: <3A32184F.547E7F8B@alsa-project.org>
Date: Sat, 09 Dec 2000 12:32:32 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Gérard Roudier <groudier@club-internet.fr>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <Pine.LNX.4.10.10012091050550.819-100000@linux.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> 
> Based on that, let me claim that most of blind barriers inserted this way
> are useless (thus sob-optimal) and may band-aid useful barriers that are
> missing. The result is subtle bugs, hidden most of the time, that we will
> have to suffer for decades.
> 
> The only way to do things right regarding ordering it to have device
> drivers _aware_ of such issues. Now, if we are happy with broken portable
> or platform-independant drivers that rely on broken hidden ordering
> alchemy rather than on correctness, then it is another story.

I see perfectly your point and this is the reason why we have
__raw_write[bwlq] in 2.4, but write[bwlq] expected semantic is to ensure
that write *happens* and are visible by other agents.

You can tell me that almost nobody uses __raw_write now and this is bad
and I agree with you, but sometime this is not a perfect world ;-)

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

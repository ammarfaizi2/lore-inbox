Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLKAii>; Sun, 10 Dec 2000 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131416AbQLKAiS>; Sun, 10 Dec 2000 19:38:18 -0500
Received: from jalon.able.es ([212.97.163.2]:15779 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129552AbQLKAiN>;
	Sun, 10 Dec 2000 19:38:13 -0500
Date: Mon, 11 Dec 2000 01:07:40 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EMU10K1 bug (all kernel ->2.4.0-test12pre7)
Message-ID: <20001211010740.C2556@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001210151153.A21525@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001210151153.A21525@ulima.unil.ch>; from greg@ulima.unil.ch on Sun, Dec 10, 2000 at 15:11:53 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000 15:11:53 Gregoire Favre wrote:
> Hello,
> 
> Well maybe not on all kernel revision, but all I tested the EMU10K1 on there
> (most off the time I use ALSA, which as the same bug...).
> 
> The bug is that the card as two audio output, they both deliver good sound
> for playing wav or mp3, but only one of them deliver the sound that came from
> the line in (same for the CD in).
> 
> I am sorry if that's not a bug and if there is an easy way to hear the sound
> out of the two output (same sound out of the two output, just mirrored).
> 

I think that depends on the player, not on the driver. The usual players only
take into account the front channels (gtcd, for example). If you use
alsaplayer to play both mp3 and CDs, the sound goes to four chans even with
CDs (but because alsaplayer is written to send the same signal to front
and rear channels).

I have been looking for a way to say to the mixer to "always mirror front
output on rear", but the mixers for emu10k are a real pain. The one that
shows all the channels, fails with the names. No one show all the features
of the chip. I even don't understand why it shows four channels in the
Main volume and 2 more for the rear.

I am thinkin of writing my own SBLive mixer for alsa, but I have found no
good description of the mixer and all the features it is supposed to have.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-pre25-vm #4 SMP Fri Dec 8 01:59:48 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

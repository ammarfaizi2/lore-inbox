Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSA0ADs>; Sat, 26 Jan 2002 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSA0ADj>; Sat, 26 Jan 2002 19:03:39 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:63759 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285850AbSA0ADc> convert rfc822-to-8bit; Sat, 26 Jan 2002 19:03:32 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Sun, 27 Jan 2002 01:03:24 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: "Nix N. Nix" <nix@go-nix.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT266 and SBLive! (emu10k1)
Message-ID: <20020127010324.K1409@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: "Nix N. Nix" <nix@go-nix.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1012086718.11336.91.camel@tux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1012086718.11336.91.camel@tux>; from nix@go-nix.ca on Sat, Jan 26, 2002 at 06:11:53PM -0500
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 06:11:53PM -0500, Nix N. Nix wrote:
> I understand (not well enough, perhaps) that there are some known
> problems with a combination of Via chipset and SBLive!.  Indeed, I have
> experienced these myself, in that sometimes, when a sound is about to
> play (as when I roll up my GNOME panel), the speakers first emit a burst
> of noise (sounds like a can of pop opening) before playing the sound.

> problem somewhat by following someone's (from Via Arena) recommendation,
> namely to move the DBLive! card to PCI slot 3.  The reason behind the
> move, accordig to the group is to obtain a unique IRQ for the card. 

> Unfortunately, the problem still surfaces occasionally.  Can you please
> advise me on what I can do to (hopefully) eliminate this problem ?

Wonder if this is related:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=53803

Try changing theese values
-CONFIG_HIGHMEM4G=y
+CONFIG_NOHIGHMEM=y

-CONFIG_SOUND_DMAP=y
+# CONFIG_SOUND_DMAP is not set

I don't know why ... but it just helped me.

(and I think that some have also succeded with i686 kernel instead of
athlon kernel)

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271698AbRHUO20>; Tue, 21 Aug 2001 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271699AbRHUO2Q>; Tue, 21 Aug 2001 10:28:16 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:9102 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271698AbRHUO2B>;
	Tue, 21 Aug 2001 10:28:01 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <d3elq5a6au.fsf@lxplus015.cern.ch> <20010821.063900.112292626.davem@redhat.com> <d3wv3x8qro.fsf@lxplus015.cern.ch> <20010821.065809.102572680.davem@redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 Aug 2001 16:28:09 +0200
In-Reply-To: "David S. Miller"'s message of "Tue, 21 Aug 2001 06:58:09 -0700 (PDT)"
Message-ID: <d3snel8p3a.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Jes Sorensen <jes@sunsite.dk> Date: 21 Aug 2001
David> 15:51:55 +0200
   
>    The much cleaner way to solve this problem is to write a
> user space tool to upgrade the image in the flash ram on the QL
> with your latest favorite image found at www.qlogic.com. It's a
> 128KB image, you can write directly to the flash in two banks
> by setting the read/write bit and setting the 2nd bank bit for
> the last 64KB.

David> When the Qlogic,FC sees a master abort, the firmware is
David> essentially cleared to zero.

David> This is what was happening to me.

Ehm, isn't the firmware only cleared to zero in the runtime memory or
are you saying that they nuke their flash ram as well? If the flash
ram is safe, you should still be able to boot any kernel and go from
there after you reset the adapter.

Clearing the firmware is still utterly stupid, but thats a firmware
stupidity. It is actually possibly to find the binary firmware image
out in the flash, but it's located at a weird location that makes me
suspect that they have some directory structure which I do not know
about.

David> If you're going to say "put the user thing in initrd", I'm
David> going to say "bite me".  I build a static kernel with no initrd
David> and that is how I'd like it to stay.  It is one thing to do
David> initrd firmware loading for devices not necessary for booting
David> and mounting root, that is acceptable, this isn't.

Well I thought Linus said we were going to have a required init
ramdisk for 2.5 anyway. But thats of course an unknown amount of time
away.

David> Jes, I think your arguments are wrong.  I think the driver
David> should have been removed in whole and replaced with something
David> like this in qlogicfc.c so everyone would know what the problem
David> is:

I disagree, the driver will still work just fine for people who have
the cards in machines such as PCs. I do agree however that it would
probably have been a good idea to leave a note in there stating why it
was removed.

However the reason I barked was because of you suggesting we remove
all firmware or should just have left it in there. If we have a GPL
violation then IMHO it has to be dealt with immediately, then we can
look at the damages afterwards.

Jes

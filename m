Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTDXEpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTDXEpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:45:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1034 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264454AbTDXEpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:45:34 -0400
Date: Wed, 23 Apr 2003 21:54:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.10.10304232112401.2033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

First Point: DRM is going to happen regardless.
Fact: NCITS T10 adopted MMC3 which is part of SCSI
Fact: MMC3 is the home of CSS.
Fact: SCSI by default supports DRM because of MMC3, see /dev/sg.

Second Point: ATA is a state machine driven protocol.
Fact: DRM requires an alternative state machine.
Fact: Hollywood forced this issue not Linus or me.

Third Point: DRM would be more difficult, had I not introduced Taskfile.
Fact: By forcing the native driver to execute a command sequencer, DRM
      requires more than simple command operations.
Fact: DRM would have happend regardless, so the best one can do is attempt
      to manage the mess.

Fourth Point: The Electronic Frontier Foundation is to BLAME!
Fact: I single handed forced Intel, IBM, Toshiba, and Matshustia to agree
      to an on-off mode for DRM with enduser control lock outs.
Fact: Feb 2001, EFF played a wild card and destroyed the deal.
Fact: IBM (4C) withdraws proposal, under firestorm.
Fact: April 2001, General Purpose Commands happen, Son-of-CPRM.
Fact: GPC creates 16-19 flavors of DRM with backdoor renable register
      banging methods.

I can not show the unpublished version of the of the proposal, unless 4C
agrees to disclose.  Given the simple fact CPRM/DRM is present now, the
only solution was to control it.  I and a few others on the NCITS T13
committee with the help of MicroSoft had managed to make it so the enduser
could disable the feature set.  Again this is all about choice not single
minded dictatorships of nothing or nothing, aka EFF.  The simple fact is
some people may want to use DRM, and to prevent them is to cause a license
twist on GPL.  So now everyone has to live with the fact that DRM is here
and it is now in the hardware.

Now the digital signing issue as a means to protect possible embedded or
distribution environments is needed.  DRM cuts two ways and do not forget
it!  We as the opensouce community can use DRM as a means to allow or deny
an operation.  Now the time has come to determine how to use this tool.
Like fire, control DRM/CPRM and you recieve benefits.  Let it run wild and
you will be burned.

For those not aware, each and every kernel you download from K.O is DRM
signed as a means to authenticate purity.

I suspect, this will fall in to the same arena as LSM, and that is where I
am going to move to push it.  DRM/CPRM has its use, and if managed well
and open we can exploit it in ways that may even cause Hollywood people to
back off.

Regards,

Andre Hedrick
LAD Storage Consulting Group

PS: If this turns into a flame fest, the absolute seriousness of this
issue will be lost.  I have rented a blowtorch and flamethrower, and
prepared to destroy people who attempt to make this messy.  One of the
last things I will do before stepping to the side, will be to resolve this
issue in a constructive way.  So if it turns nasty, I am here for the long
haul, and it has been almost two years since I have scourched lkml.  This
is not how I wanted to go out or move on to the next issue.

On Wed, 23 Apr 2003, Linus Torvalds wrote:

> 
> Ok, 
>  there's no way to do this gracefully, so I won't even try. I'm going to 
> just hunker down for some really impressive extended flaming, and my 
> asbestos underwear is firmly in place, and extremely uncomfortable.
> 
>   I want to make it clear that DRM is perfectly ok with Linux!
> 
> There, I've said it. I'm out of the closet. So bring it on...
> 
> I've had some private discussions with various people about this already,
> and I do realize that a lot of people want to use the kernel in some way
> to just make DRM go away, at least as far as Linux is concerned. Either by
> some policy decision or by extending the GPL to just not allow it.
> 
> In some ways the discussion was very similar to some of the software
> patent related GPL-NG discussions from a year or so ago: "we don't like
> it, and we should change the license to make it not work somehow". 
> 
> And like the software patent issue, I also don't necessarily like DRM
> myself, but I still ended up feeling the same: I'm an "Oppenheimer", and I
> refuse to play politics with Linux, and I think you can use Linux for
> whatever you want to - which very much includes things I don't necessarily
> personally approve of.
> 
> The GPL requires you to give out sources to the kernel, but it doesn't
> limit what you can _do_ with the kernel. On the whole, this is just
> another example of why rms calls me "just an engineer" and thinks I have
> no ideals.
> 
> [ Personally, I see it as a virtue - trying to make the world a slightly
>   better place _without_ trying to impose your moral values on other 
>   people. You do whatever the h*ll rings your bell, I'm just an engineer 
>   who wants to make the best OS possible. ]
> 
> In short, it's perfectly ok to sign a kernel image - I do it myself
> indirectly every day through the kernel.org, as kernel.org will sign the
> tar-balls I upload to make sure people can at least verify that they came
> that way. Doing the same thing on the binary is no different: signing a
> binary is a perfectly fine way to show the world that you're the one
> behind it, and that _you_ trust it.
> 
> And since I can imaging signing binaries myself, I don't feel that I can
> disallow anybody else doing so.
> 
> Another part of the DRM discussion is the fact that signing is only the 
> first step: _acting_ on the fact whether a binary is signed or not (by 
> refusing to load it, for example, or by refusing to give it a secret key) 
> is required too.
> 
> But since the signature is pointless unless you _use_ it for something,
> and since the decision how to use the signature is clearly outside of the
> scope of the kernel itself (and thus not a "derived work" or anything like
> that), I have to convince myself that not only is it clearly ok to act on
> the knowledge of whather the kernel is signed or not, it's also outside of
> the scope of what the GPL talks about, and thus irrelevant to the license.
> 
> That's the short and sweet of it. I wanted to bring this out in the open, 
> because I know there are people who think that signed binaries are an act 
> of "subversion" (or "perversion") of the GPL, and I wanted to make sure 
> that people don't live under mis-apprehension that it can't be done.
> 
> I think there are many quite valid reasons to sign (and verify) your
> kernel images, and while some of the uses of signing are odious, I don't
> see any sane way to distinguish between "good" signers and "bad" signers.
> 
> Comments? I'd love to get some real discussion about this, but in the end 
> I'm personally convinced that we have to allow it.
> 
> Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> keys in the binary. You can sign the binary that is a result of the build
> process, but you can _not_ make a binary that is aware of certain keys
> without making those keys public - because those keys will obviously have
> been part of the kernel build itself.
> 
> So don't get these two things confused - one is an external key that is
> applied _to_ the kernel (ok, and outside the license), and the other one
> is embedding a key _into_ the kernel (still ok, but the GPL requires that
> such a key has to be made available as "source" to the kernel).
> 
> 			Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVAYVfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVAYVfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAYVeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:34:08 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:55352 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262160AbVAYVaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Zovy75tDC9NdaJ0gON2QniP3pnB4mJa3mIE5w3oQFthNSVQhakLMzRmrOPExqBfTpbPJaX6Q5sqXGDKbuwh0m8+z82qQwexunGrCIQ4NT2IGMaLDEnN6TrxlOYDQ13NB7IrjpSX55EcVO4lrDSsnfdylAgUUv6KaN3bdWAVIIZc=
Message-ID: <d120d50005012513304ba0ca88@mail.gmail.com>
Date: Tue, 25 Jan 2005 16:30:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: David Brownell <david-b@pacbell.net>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
       petero2@telia.com
In-Reply-To: <200501251155.20430.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501251155.20430.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 11:55:20 -0800, David Brownell <david-b@pacbell.net> wrote:
> Quoth Pete Zaitcev:
> > ALPS Touchpad (Dualpoint) detected
> >   Disabling hardware tapping
> > input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> I have problems with an ALPS on serio4 ... different ones though.  And
> it may be that RC2 is a bit better here than previous kernels.
> 
> For example, it says it disabled tapping -- but it's still active.
> Evidently there are model-specific differences that the ALPS driver
> doesn't handle correctly.
>

Note that it says "Disabling hardware tapping". mousedev module still
does software tap emulation which can be turned off with
mousedev.tap_time = 0

> 
> > Looks like detection is correct, however either ALPS specific code doesn't work
> > right, or it sets wrong parameters, I cannot tell. Here's the list of problems,
> > from worst to least annoying:
> >
> > - Very often, keyboard stops working after a click. Typing anything has no effect.

I am not quite sure about the keyboard iteractions but all-in-all I
don't think ALPS support is really ready for prime-time yet, there
some issues with tap and double-tap detection. I think Peter has some
patches improving it though, but for now I recommend
psmouse.proto=imps.

> 
> The more serious one is that sometimes it seems to spontaneously emit click
> events while I'm moving finger across pad.  Which means I've had to learn to
> plan my "mouse" motions to avoid areas where clicking could have bad effects.
> But that's not always possible ...
> 

That is default sensitivity not suiting your habits I think. I would
recomment trying out Synaptics X driver (which also does ALPS) so you
will be able adjust sensitivity the way you like it.

-- 
Dmitry

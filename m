Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281309AbRKEUTa>; Mon, 5 Nov 2001 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281310AbRKEUTV>; Mon, 5 Nov 2001 15:19:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:2575 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281309AbRKEUTN>;
	Mon, 5 Nov 2001 15:19:13 -0500
Subject: Re: [PATCH]agp for i820 chipset
From: Robert Love <rml@tech9.net>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE6D469.8000407@epfl.ch>
In-Reply-To: <3BE6B50A.5010806@epfl.ch> <1004976089.934.12.camel@phantasy> 
	<3BE6D469.8000407@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 05 Nov 2001 15:19:12 -0500
Message-Id: <1004991553.806.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 13:03, Nicolas Aspert wrote:
> This would be great. This source _does_ need cleanup. Since I saw taht 
> everyone did copy all the functions I just did the same :-)

Yah, it is currently a mess.  I hope to have it done soon.

> I sent the patch to linux-kernel, but do you think I have to send it 
> personnally to Alan & Linus ?

You will certainly need to send it to Linus, perhaps multiple times :)

Alan may pick it up, but if he doesn't it wouldn't hurt to cut a diff
against his most recent kernel and send it to him and the list.

> > I'm not too sure why you need this.  I see other chipsets have their
> > device 0:01 defined but I can't reason why.  When I add AGP drivers I
> > never add it.  If you remove it, I think you will find everything still
> > works.
>
> Damn ! You're right :-). The first entry is needed, because the i810 
> chipset uses the secondary device (at least this is what is written in 
> the code. see the 'agp_find_supported_device' routine. I remember this 
> is needed for on-board chips. Does that make any sense :-) ? ), but the 
> i820 related one is useless (afaik).

Yah, you should be able to remove this no problem.

> > You can just use intel_generic_fetch_size or even one of the
> > i840-specific or whatever versions, here.  Note you don't use anything
> > specific to the i820, so reduce the footprint and ditch it.
> 
> The reason for rewriting this function is that, according to the Intel specs, 
> the APSIZE register is 8bits long (at least for the i820)! The generic function reads 
> 16 bits, so who knows what will be in the neighbouting register ? I guess it was 
> working by accident, but if you have an argument for sticking to the generic 'fetch_size'
> I am all ready to replace my part by the generic one :-)

Ohh, I didn't notice this.  It is odd the two sizes don't match.  If
they really are different then I agree; don't use the generic one.

> I have to leave by now, I'll check my e-mail tonight, but it is
> likely that I won't make any patch before tomorrow :-(

No problem ... send it along when you do.

	Robert Love


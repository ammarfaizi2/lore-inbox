Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWILT6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWILT6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWILT6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:58:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:2481 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030391AbWILT6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:58:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JcMM5mByKsqXi+erLkrGEsdTsMYYB2/oBvOUT2+yULmrMIhHGwSDnTZOsbtnaUmUeR3jhXK/04t3yuXShdvUFKd5jr2R0M2zt9PK0/PDv5/xHp0SjqzaMPhpmg1DOHsUb2C/J/Rx9zJJUHddJethb6A0YOW91sciLE1wPHjFG+0=
Message-ID: <d120d5000609121258j408a74bfqb507126a45672d6@mail.gmail.com>
Date: Tue, 12 Sep 2006 15:58:42 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
Subject: Re: [RFC] OLPC tablet input driver, take three.
In-Reply-To: <20060912193918.GE4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <20060910201036.GD4187@aehallh.com>
	 <20060911190225.GS4181@aehallh.com>
	 <d120d5000609111210ud9ea310y40675db6e5edbed@mail.gmail.com>
	 <20060912193918.GE4187@aehallh.com>
X-Google-Sender-Auth: 3809af534df3f0a3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Mon, Sep 11, 2006 at 03:10:06PM -0400, Dmitry Torokhov wrote:
> > On 9/11/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> > >
> > >4: Technical: I've not implemented the KCONFIG option for this driver
> > >yet, it's on my todo list, but for after we get the sample rate stuff
> > >figured out.
> > >
> > >
> > >That said, here the patch, it seems to work, and it's time to at least
> > >get into the OLPC kernel tree, if not mainline.
> > >
> >
> > Zephaniah,
> >
> > What are the chances that commodity hardware will have OLPC device
> > present? If there are none (or extremely slim) I think we'd better
> > wait for Kconfig option to be implemented before adding this to
> > mainline because psmouse is already too fat.
>
> Extremely slim, the current generation of samples are 3.3V units instead
> of 5V units.
>
> When I go in and do this, would it make sense to split out most of the
> external to psmouse-base.c drivers to be options, most tied to being on
> unless CONFIG_EMBEDDED is enabled?
>

Yes, that would be nice. Just keep in mind that we need to detect
synaptics touchpads even if driver support is disabled so that we can
properly reset them if they don't support imex or exps protocols.
Otherwise the trackpoint connected to the pass-through port stops
working.

-- 
Dmitry

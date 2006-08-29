Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWH2PMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWH2PMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWH2PMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:12:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:44489 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964958AbWH2PMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:12:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KXt8a2x/aDZc1ZVbfhrKqCfLj6Qdo3kwlWa43uT7T8gZ5LT5X9reTfxAcHDQ402Q/CDU/xk3h/gcLwc+c5tRdwbHUqo9E5tpSUh2XoWCx3U3dyb1n2hRIuQAjLJOeO6zae8kY6o/9Z5FPGBgLhkjbeTIHnNgBgAy16alM0YRAhs=
Message-ID: <d120d5000608290812g5bcfac3dx928aa55f4777bc3e@mail.gmail.com>
Date: Tue, 29 Aug 2006 11:12:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
In-Reply-To: <20060829143502.GC4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <d120d5000608290553t275b4acar925f66b3d0c7434b@mail.gmail.com>
	 <20060829143502.GC4187@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Tue, Aug 29, 2006 at 08:53:17AM -0400, Dmitry Torokhov wrote:
> > Hi,
> >
> > On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> > >The OLPC will ship with a somewhat unique input device made by ALPS,
> > >connected via PS/2 and speaking a protocol only loosely based on that
> > >spoken by other ALPS devices.
> > >
> >
> > Do you have a formal programming spec for it?
>
> Not that I can currently distribute.
>
> Converting to html, trimming out hardware detail, and feeding it through
> channels for ALPS to say that they are comfortable with the amount of
> data being released is on my todo list, but behind a few other things.

I see. Well, if you have a decent contacts in ALPS could you ask them
if they could release any information on their other hardware?

> >
> > >4: Technical/policy: Buttons are currently sent to both of the input
> > >devices we generate, I don't see any way to avoid this that is not a
> > >policy decision on which buttons belong to which device, but I'm open to
> > >suggestions.
> > >
> >
> > Is it not known how actual hardware wired?
>
> Hardware is wired with one device, which is quite wide.  The entire
> width can be accessed via the PT sensor, and the middle 1/3rd with the
> GS sensor.
>
> I believe that the buttons will be one on each side, though I'm not
> positive, and the PT data, the GS data, and the button data all arrive
> in the same packet.
>
> So really there is no 'right' way from the kernel driver's point of
> view, the buttons belong equally to both.
>
> The kernel driver that this will be matched with will probably leave it
> as a user configuration setting as to which one it will throw button
> presses away for.

OK.

>
> > >+       dev2->name = "OLPC OLPC GlideSensor";
> >
> > "OLPC OLPC"?
>
> To match the first one, with a protocol name of OLPC and a vendor of
> OLPC we end up with 'OLPC OLPC' for the first one, this is, IMHO, rather
> suboptimal, but I'm not sure what else to do here.
>

Should not vendor be still ALPS?

-- 
Dmitry

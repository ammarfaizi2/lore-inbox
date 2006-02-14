Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWBNMGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWBNMGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBNMGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:06:03 -0500
Received: from smtp.enter.net ([216.193.128.24]:58886 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161026AbWBNMGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:06:01 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 07:15:00 -0500
User-Agent: KMail/1.8.1
Cc: jerome.lacoste@gmail.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <43F0CBF0.nailMFL11QJR1@burner> <43F1BFA8.nailMWZ21G8NF@burner>
In-Reply-To: <43F1BFA8.nailMWZ21G8NF@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140715.01229.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 06:31, Joerg Schilling wrote:
> Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > jerome lacoste <jerome.lacoste@gmail.com> wrote:
> > > but thank to that proposal, one would also have:
> > >
> > > 1,0,0 <= /dev/hdc
> > > 2,0,0 <= /dev/hdd
> > >
> > > I think it's a good compromise between what the users want and what you
> > > want.
> > >
> > > So, WDYT?
> >
> > If this would not be Linux only, go ahead.
> >
> > Note that you would have to do real hard work as it is not trivial to
> > prove your patch on all supported OS....
>
> I did get no reply.
>
> Does this mean that you are no longer interested because I request real
> work instead of a cheap hack?


Joerg, enough with the personal attacks. That you didn't see the reply is just 
proof that you don't read the entirety of messages posted or sent to you 
directly. 

here is both responses:

in one he posts the contents of a single line of code that he added to the 
linux wrapper code in libscg.

In the second he asks for a guarantee that you will stand behind your 
(somewhat sketchy) posted guidelines for patches.

And what follows from here out is the relevant portions of the messages, 
complete with the "Message ID" field from the headers in case you want to dig 
through you inbox or wherever you misfiled these responses to read the 
entirety of them.

DRH

Message-ID: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>

<snip>
I am aiming for a compromise.

My point is that people want to use dev=/dev/hdc in their interface,
because that's what they are used to. That's a point that I think you
cannot deny.

If you want to still keep your dev=b,t,l command line interface, just
let the users know how your mapping is done. That will allow a
cdrecord wrapper to first query the mapping, then using this mapping
information and OS specific information (e.g. links) identify the
b,t,l expected by your interface.

That way you have mostly no code change to do. And you keep your b,t,l
naming. Everybody is happy.

I've added something like:

                fprintf(stdout, "%d,%d,%d <= /dev/%s\n",
                                first_free_schilly_bus, t, l, 
token[ID_TOKEN_SUBSYSTEM] );

in scsi-linux-ata.c and it does what I want.

WDYT?

Cheers,

Jerome

Message-ID: <5a2cf1f60602130608qf6a2575ucbd57615eb32cc67@mail.gmail.com>

On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
>
> > > Are you accepting such a patch?
> >
> > If his response to the last patch someone provided is any example the 
answer
> > is going to be no. And I firmly believe the old adage that a leopard can't
> > change it's spots.
>
> Any patch that
>
> -       does not break things
>
> -       fits into the spirit of the currnt implementation
>
> -       offers useful new features
>
> -       conforms to coding style standards
>
> -       does not need more time to integrate than I would need to
>         write this from scratch
>
> Unfortunately, many people who send patches to me do not follow
> these simple rules.

I am still waiting for an answer as to whether such a patch would be
accepted. We will take on the practical details later on.

Jerome


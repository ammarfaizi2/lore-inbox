Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJOV1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJOV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:27:40 -0400
Received: from 194-179-2-161.mad.ttd.net ([194.179.2.161]:27344 "EHLO
	pc22.admin.cnc") by vger.kernel.org with ESMTP id S261732AbTJOV1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:27:38 -0400
Date: Wed, 15 Oct 2003 23:27:35 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Celso =?iso-8859-1?Q?Gonz=E1lez?= <celso@mitago.net>
cc: Marc Giger <gigerstyle@gmx.ch>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: airo regression with Linux 2.4.23-pre2
In-Reply-To: <20031015194754.GA14859@viac3>
Message-ID: <Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've been out for a few days, so I'm now catching up with e-mail...

Anyway, I've been discussing this issue with Celso and looks like the line
he mentions make his configuration fail. I added it because in other cases
it makes it work. Anyway, please test the driver removing that line and if
it fixes the problem I'll just try to figure out the exact cases when it's
neede (Cisco hasn't been very helpful about it)..

On Wed, 15 Oct 2003, Celso González wrote:

> On Wed, Oct 15, 2003 at 07:32:02PM +0200, Udo A. Steinberg wrote:
> >
> > Hi,
> >
> > My Cisco Aironet 350 Series PCMCIA network card does no longer work with the
> > latest 2.4 and 2.6 kernels. For 2.4.23 I have been able to identify the point
> > in time at which things broke. 2.4.23-pre1 still works and -pre2 does not.
> > The card is unable to acquire an IP address via DHCP and also doesn't seem to
> > receive any networking traffic at all with -pre2 and later.
> >
> > Looking at the 2.4 changelog it seems that the following patch introduced
> > the problem.
> >
> > MT> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> > MT> ============================================
> > MT> <javier:tudela.mad.ttd.net>:
> > MT>   o [wireless airo] add support for MIC and latest firmwares
> >
> > Do you have any idea what is going wrong here? If you need more information
> > to narrow down the problem, just ask.
>
> Same simptoms as me
> Try removing this line on airo.c
> Line 2948
> ai->config._reserved1a[0] = 2 /* ??? */
>
> It works for me
>
> --
> Celso
>
>
>




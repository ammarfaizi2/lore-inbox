Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTLPT6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTLPT6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:58:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59838 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262174AbTLPT6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:58:10 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bob <recbo@nishanet.com>
Subject: Re: IRQ disabled (SATA) on NForce2 and my theory
Date: Tue, 16 Dec 2003 21:00:25 +0100
User-Agent: KMail/1.5.4
References: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org> <200312151555.51845.bzolnier@elka.pw.edu.pl> <3FDE8258.4050801@nishanet.com>
In-Reply-To: <3FDE8258.4050801@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312162100.25609.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 of December 2003 04:56, Bob wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >On Monday 15 of December 2003 07:06, Bob wrote:
> >>sii chips have a long history of needing to
> >>hdparm off the unmask interrupt feature.
> >>
> >>I don't know about that chip but for
> >>sii680 there is a special option "-p9"
> >>for hdparm which is to say pio mode 9
> >>is a special instruction in addition to
> >>standard hdparm opt "-u0" turning off
> >>irq unmask.
> >
> >There is no such thing as 'special option "-p9"' for sii680.
>
> Passing PIO mode 9 to sii680 will make it do udma133 with
> unmask off, same as "-X70 -u0". What sii did was to make a
> bug a feature by embedding their own special pio mode for the
> well-known cmdxxx unmask off requirement.

Please point me to the code or documentation...

> Making A Bug A Feature is begging for "deprecation".
>
> Since -p9 was only documented to set u133 and unmask off,

Where is it documented?

> making a bug a feature, non-bug features are not user-expected
> to be set without using other(normal) hdparm options, so
> somebody might as well "man hdparm" and bypass the silly
> kludge which probably was an internal office joke anyway.

Are you talking about drivers/ide/pci/siimage.c driver or something else?

> -Bob
>
> >>/sbin/hdparm -d1 -c1 -p9 -X70 -u0 -k0 -i $a
> >
> >-X70 is only valid if your device is UDMA133.
> >
> >--bart


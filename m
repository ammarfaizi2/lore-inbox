Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUEQHEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUEQHEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUEQHEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 03:04:04 -0400
Received: from dialpool3-61.dial.tijd.com ([62.112.12.61]:12677 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264916AbUEQHD7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 03:03:59 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Mon, 17 May 2004 09:04:20 +0200
User-Agent: KMail/1.6.2
References: <200405161222.48581.lkml@kcore.org> <200405170832.32256.lkml@kcore.org> <200405170142.41289.dtor_core@ameritech.net>
In-Reply-To: <200405170142.41289.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405170904.24471.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 17 May 2004 08:42, Dmitry Torokhov wrote:
> On Monday 17 May 2004 01:32 am, Jan De Luyck wrote:
> > On Sunday 16 May 2004 21:29, Dmitry Torokhov wrote:
> > > On Sunday 16 May 2004 02:06 pm, Jan De Luyck wrote:
> > > > On Sunday 16 May 2004 19:18, Dmitry Torokhov wrote:
> > > > > Hmm.. there was no changes to PS/2 processing between 2.6.5 and
> > > > > 2.6.6 except for some Logitech tweaking, but it should not affect
> > > > > Synaptics handling in any way...
> > > > >
> > > > > Could you check if you still have DMA enabled on your disks, check
> > > > > your time source (TSC, ACPI PM timer, etc) and probably boot with
> > > > > acpi off?
> > > > >
> > > > > Thank you.
> > > >
> > > > Dmitry,
> > > >
> > > > Booting with acpi=off fixes the problem, although I'm curious to what
> > > > the problem actually is.
> > > >
> > > > I've attached the dmesgs from 2.6.6, 2.6.5, and 2.6.6 with acpi=off.
> > > >
> > > > There is a line that says "Invalid control registers" that I wonder
> > > > where it comes from, but you might see something more here than I do.
> > >
> > > It comes from speedstep-centrino module, could you please try booting
> > > with ACPI but without speedstep-centrino loaded? Also, does it help if
> > > you do not compile/ load ACPI battery module?
> >
> > Neither has any effect.
> >
> > I've also disabled CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI, figuring there
> > might be some problem with that, but that doesn't change a thing.
>
> Perhaps we need to check with ACPI guys as it seems that you are affected
> by this code and there were some changes to ACPI subsystem between 2.6.5
> and 2.6.6.

Ok. Passing on to acpi-devel@lists.sourceforge.net.

I've looked in the archives, and the problem looks very much like the one in 
this thread:

http://sourceforge.net/mailarchive/forum.php?thread_id=4172848&forum_id=6102

And I've been noticing some keyboard glitches too, but these were to 
unfrequent, and usually occur only in one application (gaim) so I figured it 
might be a bug in gaim... guess not...

Unfortunately, the hints in this thread don't help. I've browsed the input 
system FAQ, but no dice.

The only thing that gives me a working synaptics touchpad is acpi=off.

It worked fine with 2.6.5.

Jan

- -- 
Those who do things in a noble spirit of self-sacrifice are to be avoided
at all costs.
		-- N. Alexander.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqGP3UQQOfidJUwQRAoXUAJ9nKMmfc6x72u3nJbJl+PZi3q0U3QCeO8N5
+KJEgm5HKq+gwOAh7A/Z3cA=
=ONlN
-----END PGP SIGNATURE-----

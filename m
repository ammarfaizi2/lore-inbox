Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUCNQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 11:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCNQm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 11:42:28 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:43469 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261376AbUCNQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 11:42:25 -0500
Date: Sun, 14 Mar 2004 17:33:10 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: paul.devriendt@amd.com
Cc: Pavel Machek <pavel@suse.cz>, patches@x86-64.org,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@redhat.com,
       ducrot@poupinou.org
Subject: Re: powernow-k8 updates
Message-ID: <20040314163310.GB24433@dominikbrodowski.de>
Mail-Followup-To: paul.devriendt@amd.com,
	Pavel Machek <pavel@suse.cz>, patches@x86-64.org,
	Cpufreq mailing list <cpufreq@www.linux.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>, davej@redhat.com,
	ducrot@poupinou.org
References: <20040309214830.GA1240@elf.ucw.cz> <20040310110941.GC28592@poupinou.org> <20040310113246.GA4775@atrey.karlin.mff.cuni.cz> <20040310134811.GD28592@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20040310134811.GD28592@poupinou.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2004 at 02:48:11PM +0100, Bruno Ducrot wrote:
> ducrot@poupon:~/kernel/linux-2.6.4-bk-acpi> grep EXPORT drivers/acpi/proc=
essor.c
> EXPORT_SYMBOL(acpi_processor_register_performance);
> EXPORT_SYMBOL(acpi_processor_unregister_performance);
> EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
>=20
> So all you need are acpi_processor_register_performance() and
> acpi_processor_unregister_performance().  I'm pretty sure that those
> functions are in 2.6.4-rc2.

These functions are indeed in 2.6.3 and 2.6.4 -- and they work fine. If you
have any questions related to them, please ask me.
=20
> If you want to play with those functions, you have to include
> <acpi/processor.h>, and then you have to register a driver via:
> acpi_processor_register_performance(&pr, cpu) where:
> - cpu is the cpu id (point-of-view of Linux, not the acpi cpu id),
> - pr is a struct acpi_processor_performance (defined in
>   acpi/processor.h).
>=20
> You will have then for free:
> - configurations via the acpi_processor_performance structure,
> - handling of the _PPC object, so that you don't have to care about
>   changes for that in the driver.  That will be done via classic
>   ACPI event notifications to the processor, via the limit interface
>   writen in drivers/acpi/processor.c, and cpufreq notion of notifiers.

Minor correction: only the first and last steps are indeed used to handle
_PPC, IIRC.

Also, you'll have
- support for _PDC, if needed
- proper embedding into ACPI core
- the /proc/acpi/processor/./performance interface which some still tend to
   like...

	Dominik

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVIlGZ8MDCHJbN8YRAktuAJ9zTn9OfnOElU+tFH24TxnRaI/1zACgjpM7
iILO3EKJWkjSuI4ovL6rMv0=
=0m0y
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

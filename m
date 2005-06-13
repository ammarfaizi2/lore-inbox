Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVFMQry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVFMQry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFMQrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:47:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26628 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261797AbVFMQrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:47:40 -0400
Message-Id: <200506131647.j5DGl0ke009926@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2 
In-Reply-To: Your message of "Mon, 13 Jun 2005 08:25:07 PDT."
             <20050613152507.GB7862@atomide.com> 
From: Valdis.Kletnieks@vt.edu
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu>
            <20050613152507.GB7862@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118681219_5914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 12:47:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118681219_5914P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 08:25:07 PDT, Tony Lindgren said:

> You may also want to check out the patch by Thomas Renninger for ACPI
> C-states. I've added a link to it at:
> 
> http://muru.com/dyntick/

I think that's muru.com/linux/dyntick ?

I'm not sure what Thomas's patch will do for me - here's what I currently have:

% cat /proc/acpi/processor/CPU0/power 
active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[050] usage[01314979]

Near as I can tell, we start off in C1, drop into C2, and stay there no
matter what happens - we never move back up to C1, and there's no C3 to drop
into....

Should there be a C3/C4?  Is my laptop just plain borked? :)

--==_Exmh_1118681219_5914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrbiDcC3lWbTT17ARAuBhAKCeJ7J5ZquicQvusoFw8f3pIWETYwCgxvFz
FVaS+OfagW57ASIm19vDvZQ=
=zpmq
-----END PGP SIGNATURE-----

--==_Exmh_1118681219_5914P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271817AbTGXXv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271818AbTGXXv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:51:58 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:23558 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271817AbTGXXv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:51:56 -0400
Date: Thu, 24 Jul 2003 17:07:03 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030725000703.GD23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <20030724231421.GQ1512@phunnypharm.org> <20030724234837.GC23196@ruvolo.net> <20030724234503.GR1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <20030724234503.GR1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2003 at 07:45:03PM -0400, Ben Collins wrote:
> If it wasn't being updated, I would see the problem too, and I'm not.

On another note, I just got this output when doing a 'rmmod' ohci1394:

bad: scheduling while atomic!
Call Trace:
 [<c01159c7>] schedule+0x3b7/0x3c0
 [<c0115d28>] wait_for_completion+0x78/0xd0
 [<c0115a20>] default_wake_function+0x0/0x30
 [<c0115a20>] default_wake_function+0x0/0x30
 [<c01226c0>] kill_proc_info+0x40/0x60
 [<c89ddff5>] nodemgr_remove_host+0x55/0xa0 [ieee1394]
 [<c89d9b66>] highlevel_remove_host+0x76/0x90 [ieee1394]
 [<c89c56ee>] ohci1394_pci_remove+0x3e/0x160 [ohci1394]
 [<c01a44eb>] pci_device_remove+0x3b/0x40
 [<c01c4efe>] device_release_driver+0x5e/0x60
 [<c01c4f2b>] driver_detach+0x2b/0x40
 [<c01c518b>] bus_remove_driver+0x3b/0x70
 [<c01c55b4>] driver_unregister+0x14/0x28
 [<c01a47a7>] pci_unregister_driver+0x17/0x30
 [<c89c5ad2>] ohci1394_cleanup+0x12/0x16 [ohci1394]
 [<c012cdc5>] sys_delete_module+0x125/0x190
 [<c013fcb3>] sys_munmap+0x43/0x70
 [<c010940b>] syscall_call+0x7/0xb


--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IHSnKO6EG1hc77ERAoRIAJ9Cv0N/dJV6AsNgOxXum6LK/6uhGwCdFdJT
YPPaVXpLTetwWkCPmwo4EOU=
=wtxV
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

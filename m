Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVAaWAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVAaWAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVAaWAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:00:49 -0500
Received: from main.gmane.org ([80.91.229.2]:39884 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261388AbVAaWAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:00:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.11-rc2-mm2
Date: Mon, 31 Jan 2005 22:46:12 +0100
Message-ID: <41FEA724.1060404@free.fr>
References: <20050129131134.75dacb41.akpm@osdl.org> <7f800d9f05013113157978f158@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: lns-vlq-38-lyo-82-253-135-69.adsl.proxad.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
In-Reply-To: <7f800d9f05013113157978f158@mail.gmail.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le 31.01.2005 22:15, Andre Eisenbach a écrit :
| Andrew,
|
| My PCMCIA slot (yenta_socket) doesn't work anymore with
| 2.6.11-rc2-m2. See the dmesg output below. It works fine with
| 2.6.11-rc1-mm1.
|
| Let me know if you need any additional information.
|
| Thanks,
|     Andre
|
| --- snipp ---
|
| Linux Kernel Card Services
|   options:  [pci] [cardbus] [pm]
| kobject_register failed for pcmcia_core (-17)
|  [<c021686b>] kobject_register+0x5b/0x70
|  [<c0130620>] mod_sysfs_setup+0x50/0xb0
|  [<c0131999>] load_module+0x959/0xaa0
|  [<c0131b6b>] sys_init_module+0x5b/0x1a0
|  [<c010300d>] sysenter_past_esp+0x52/0x75
| rsrc_nonstatic: Unknown symbol release_cis_mem
| rsrc_nonstatic: Unknown symbol pcmcia_socket_list
| rsrc_nonstatic: Unknown symbol pccard_validate_cis
| rsrc_nonstatic: Unknown symbol destroy_cis_cache
| rsrc_nonstatic: Unknown symbol pcmcia_socket_list_rwsem
| yenta_socket: Unknown symbol dead_socket
| yenta_socket: Unknown symbol pcmcia_register_socket
| yenta_socket: Unknown symbol pcmcia_socket_dev_resume
| yenta_socket: Unknown symbol pcmcia_parse_events
| yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
| yenta_socket: Unknown symbol pccard_nonstatic_ops
| yenta_socket: Unknown symbol pcmcia_unregister_socket
| kobject_register failed for pcmcia_core (-17)
|  [<c021686b>] kobject_register+0x5b/0x70
|  [<c0130620>] mod_sysfs_setup+0x50/0xb0
|  [<c0131999>] load_module+0x959/0xaa0
|  [<c0131b6b>] sys_init_module+0x5b/0x1a0
|  [<c010300d>] sysenter_past_esp+0x52/0x75
| pcmcia: Unknown symbol pcmcia_get_socket
| pcmcia: Unknown symbol pcmcia_get_window
| pcmcia: Unknown symbol pcmcia_suspend_card
| pcmcia: Unknown symbol pcmcia_replace_cis
[snip]

I had the same type of problem while loading modules.

Fixed this evening by the following patch :
http://marc.theaimsgroup.com/?l=linux-kernel&m=110715631504335

- --
laurent

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB/qckUqUFrirTu6IRAv/0AJ0QUOkcckgIUQXaKMca4g1MGcp3xACggDua
+UoG14EdUPEYTiJptVkpSbQ=
=XLpz
-----END PGP SIGNATURE-----


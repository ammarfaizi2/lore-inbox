Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVBABa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVBABa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 20:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVBABaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 20:30:25 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:19842 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261454AbVBABaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 20:30:13 -0500
Message-ID: <41FEDAA9.3070504@cwazy.co.uk>
Date: Mon, 31 Jan 2005 20:26:01 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Laurent Riffard <laurent.riffard@free.fr>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc2-mm2
References: <20050129131134.75dacb41.akpm@osdl.org> <7f800d9f05013113157978f158@mail.gmail.com> <41FEA724.1060404@free.fr>
In-Reply-To: <41FEA724.1060404@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [70.16.225.90] at Mon, 31 Jan 2005 19:26:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Le 31.01.2005 22:15, Andre Eisenbach a écrit :
> | Andrew,
> |
> | My PCMCIA slot (yenta_socket) doesn't work anymore with
> | 2.6.11-rc2-m2. See the dmesg output below. It works fine with
> | 2.6.11-rc1-mm1.
> |
> | Let me know if you need any additional information.
> |
> | Thanks,
> |     Andre
> |
> | --- snipp ---
> |
> | Linux Kernel Card Services
> |   options:  [pci] [cardbus] [pm]
> | kobject_register failed for pcmcia_core (-17)
> |  [<c021686b>] kobject_register+0x5b/0x70
> |  [<c0130620>] mod_sysfs_setup+0x50/0xb0
> |  [<c0131999>] load_module+0x959/0xaa0
> |  [<c0131b6b>] sys_init_module+0x5b/0x1a0
> |  [<c010300d>] sysenter_past_esp+0x52/0x75
> | rsrc_nonstatic: Unknown symbol release_cis_mem
> | rsrc_nonstatic: Unknown symbol pcmcia_socket_list
> | rsrc_nonstatic: Unknown symbol pccard_validate_cis
> | rsrc_nonstatic: Unknown symbol destroy_cis_cache
> | rsrc_nonstatic: Unknown symbol pcmcia_socket_list_rwsem
> | yenta_socket: Unknown symbol dead_socket
> | yenta_socket: Unknown symbol pcmcia_register_socket
> | yenta_socket: Unknown symbol pcmcia_socket_dev_resume
> | yenta_socket: Unknown symbol pcmcia_parse_events
> | yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
> | yenta_socket: Unknown symbol pccard_nonstatic_ops
> | yenta_socket: Unknown symbol pcmcia_unregister_socket
> | kobject_register failed for pcmcia_core (-17)
> |  [<c021686b>] kobject_register+0x5b/0x70
> |  [<c0130620>] mod_sysfs_setup+0x50/0xb0
> |  [<c0131999>] load_module+0x959/0xaa0
> |  [<c0131b6b>] sys_init_module+0x5b/0x1a0
> |  [<c010300d>] sysenter_past_esp+0x52/0x75
> | pcmcia: Unknown symbol pcmcia_get_socket
> | pcmcia: Unknown symbol pcmcia_get_window
> | pcmcia: Unknown symbol pcmcia_suspend_card
> | pcmcia: Unknown symbol pcmcia_replace_cis
> [snip]
> 
> I had the same type of problem while loading modules.
> 
> Fixed this evening by the following patch :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110715631504335
> 
> - --
> laurent
> 

I can confirm that patch took care of a similar kobject_register failure in tulip 
on my test machine.

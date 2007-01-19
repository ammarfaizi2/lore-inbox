Return-Path: <linux-kernel-owner+w=401wt.eu-S932852AbXASCVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbXASCVd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 21:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASCVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 21:21:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58084 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852AbXASCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 21:21:32 -0500
Date: Thu, 18 Jan 2007 18:21:24 -0800
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [BUG] 2.6.20-rc4-mm1: Panic in e1000_write_vfta_82543()
Message-ID: <20070119022124.GA8087@us.ibm.com>
References: <20070119011740.GA7658@us.ibm.com> <45B02510.7050604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B02510.7050604@intel.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok [auke-jan.h.kok@intel.com] wrote:
| Sukadev Bhattiprolu wrote:
| >I get following panic on 2.6.20-rc4-mm1 on a 2-cpu AMD Opteron system.
| >
| >Same basic config file seems to work with 2.6.20-rc2-mm1 on this same
| >system. Have not tried -rc3-mm1 yet.
| >
| >Attached are config file and "lspci -vv" output. Let me know if you need
| >more info.
| >
| >Suka
| >
| >---
| >
| >[  168.925840] Freeing unused kernel memory: 320k freed
| > * INIT: version 2.86 booting
| > * Starting basic networking...                                          [ 
| > ok ]
| > * Starting kernel event manager...                                      [ 
| > ok ]
| > * Loading hardware drivers...                                           [ 
| > ok ]
| > * Starting PCMCIA services... * PCMCIA not present
| > * Loading manual drivers...                                             [ 
| > ok ]
| >[  171.575122] Unable to handle kernel paging request at ffffc20100ec55fc 
| >RIP:
| >[  171.584632]  [<ffffffff804a9858>] e1000_write_vfta_82543+0x58/0xd0
...
| >[  171.698208] Call Trace:
| >[  171.698216]  [<ffffffff804c103d>] e1000_vlan_rx_register+0x1dd/0x210
| >[  171.698219]  [<ffffffff804c3195>] e1000_up+0x35/0x4b0
| >[  171.698222]  [<ffffffff804c3724>] e1000_open+0x74/0x100
| >[  171.698227]  [<ffffffff805626fe>] dev_open+0x3e/0xa0
| >[  171.698230]  [<ffffffff8056184f>] dev_change_flags+0x6f/0x160
| >[  171.698234]  [<ffffffff805a5174>] devinet_ioctl+0x2d4/0x6e0
| >[  171.698238]  [<ffffffff803f7e01>] __up_read+0x21/0xb0
| >[  171.698243]  [<ffffffff8055664c>] sock_ioctl+0x1fc/0x230
| >[  171.698247]  [<ffffffff8029dc0f>] do_ioctl+0x2f/0xa0
| >[  171.698249]  [<ffffffff8029df3b>] vfs_ioctl+0x2bb/0x2f0
| >[  171.698252]  [<ffffffff8029dfb9>] sys_ioctl+0x49/0x80
| >[  171.698256]  [<ffffffff805e375d>] error_exit+0x0/0x84
| >[  171.698259]  [<ffffffff802098be>] system_call+0x7e/0x83
| >[  171.698261]
| >[  171.698262]
| >[  171.698262] Code: 44 8b 20 e8 30 7e 00 00 83 bb 94 01 00 00 03 75 3c 83 
| >e5 01
| >[  171.698268] RIP  [<ffffffff804a9858>] e1000_write_vfta_82543+0x58/0xd0
| >[  171.698273]  RSP <ffff81007dfc5cf8>
| >[  171.698274] CR2: ffffc20100ec55fc
| >[  171.698276]  <6>EXT3 FS on sda1, internal journal
| 
| Hi,
| 
| I believe this is one of the bugs that is fixed in the patch that I sent 
| monday. Please
| try again with the patch applied to your tree and re-test. Thanks. I didn't 
| see Andrew
| merge the patch yet.
| 
| see: http://lkml.org/lkml/2007/1/16/226
| 
| I can mail the patch if you can't find it. Just ping me privately.

Yep. Seems to fix the crash. Thanks !

Suka
| 
| Cheers,
| 
| Auke

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUGDLmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUGDLmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUGDLmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:42:22 -0400
Received: from smtp08.web.de ([217.72.192.226]:966 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S265534AbUGDLmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:42:21 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7: sk98lin unload oops
Date: Sun, 4 Jul 2004 13:42:03 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041342.18821.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

to test the parameters of the sk98lin module I have a script, that stops the 
network, unloads and re-loads the module and starts the network again.

After executing the script dmesg shows this oops:

Badness in remove_proc_entry at fs/proc/generic.c:685
 [<c0107d19>] dump_stack+0x19/0x20
 [<c018c54f>] remove_proc_entry+0xbf/0x110
 [<f8a42fef>] skge_cleanup_module+0x19f/0x1a9 [sk98lin]
 [<c01360a2>] sys_delete_module+0x152/0x190
 [<c0106e57>] syscall_call+0x7/0xb


Fortunality everything still works fine (I'm running the script over the 
network of the syskonnect cards).

This machine has two of those syskonnect cards, on another machine which has 
only one syskonnect card this oops doesn't occur.


Thanks,
	Bernd

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTIONxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbTIONxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:53:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1152 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261359AbTIONxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:53:01 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16229.50231.715275.197988@laputa.namesys.com>
Date: Mon, 15 Sep 2003 17:52:55 +0400
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Oleg Drokin <green@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot 20030905 [OOPS]
In-Reply-To: <Pine.LNX.4.51.0309151249310.1934@dns.toxicfilms.tv>
References: <20030826102233.GA14647@namesys.com>
	<Pine.LNX.4.51.0309151249310.1934@dns.toxicfilms.tv>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak writes:
 > Hi,
 > 
 > I compiled the kernel (2.6.0-test5) without key_large support
 > I attached a disk /dev/hda (I'm booting off /dev/hdb)
 > 
 > # mkfs.reiser4 /dev/hda1
 > Went ok
 > 
 > # mount -t reiser4 /dev/hda1 /1
 > And here's the output. It seems unsupported keys cause null pointer
 > dereference.

This is known problem. Actually, reiser4 mount function cannot handle
errors very well at the moment.

 > 
 > reiser4[mount(1504)]: get_ready_format40 (fs/reiser4/plugin/disk_format/disk_format40.c:229)[nikita-3228]:
 > WARNING: Key format mismatch. Only small keys are supported.
 > Unable to handle kernel NULL pointer dereference at virtual address 00000000
 >  printing eip:

[...]

 >  [<c0109089>] sysenter_past_esp+0x52/0x71
 > 

Nikita.

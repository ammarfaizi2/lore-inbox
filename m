Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUFVN4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUFVN4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUFVN4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:56:41 -0400
Received: from gw.c9x.org ([213.41.131.17]:13701 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S263790AbUFVNyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:54:21 -0400
Date: Tue, 22 Jun 2004 15:53:54 +0159
From: Jedi/Sector One <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Badness in futex_wait
Message-ID: <20040622135416.GA23543@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

  I just had this with a 2.6.7-rc3-mm1 kernel:
  
Badness in futex_wait at kernel/futex.c:542
 [<c0128634>] futex_wait+0x180/0x18a
 [<c0114156>] default_wake_function+0x0/0xc
 [<c0114156>] default_wake_function+0x0/0xc
 [<c0128862>] do_futex+0x35/0x7f
 [<c012898c>] sys_futex+0xe0/0xec
 [<c0112cd1>] schedule_tail+0x15/0x4c
 [<c0103bdd>] sysenter_past_esp+0x52/0x71

  Is it harmless?
  

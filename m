Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUKPOB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUKPOB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKPOBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:01:23 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:13482 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261738AbUKPOBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:01:18 -0500
To: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116120226.A27354@pauline.vellum.cz> (message from Jan
	Kratochvil on Tue, 16 Nov 2004 12:02:26 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
Message-Id: <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 15:01:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "fuse/version" you have in /proc while it belongs to /proc
> "fuse/dev"     you have in /proc while it belongs to /dev

Well, 'Documentation/devices.txt' says:

  THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
  TREE.  At Linus' request, no more allocations will be made official
  for Linus' kernel tree; the 3 June 2001 version of this list is the
  official final version of this registry.

So placing it in /proc doesn't seem to me such a bad idea.

> Also I am not sure human-readable "fuse/version" is required there at all.
> Regular FUSE request enlisted in 'enum fuse_opcode' would be enough.

This would break the assumption that no requests can be received until
the filesystem is mounted.

Miklos

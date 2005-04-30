Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVD3QAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVD3QAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVD3QAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:00:38 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:37809 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261270AbVD3QAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:00:32 -0400
To: jamie@shareable.org
CC: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050430143609.GA4362@mail.shareable.org> (message from Jamie
	Lokier on Sat, 30 Apr 2005 15:36:09 +0100)
Subject: Re: [PATCH] private mounts
References: <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org>
Message-Id: <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 17:59:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, in terms of complexity, it's not much different from using
> bind mounts.

As has been suggested by Pavel, bind mounting foreign namespaces could
just be done with a new bind_fd(fd, path) syscall and file descriptor
passing with SCM_RIGHTS.

That sounds to me orders of magnitude less complex (on the kernel side
at least) than sb sharing.

Miklos




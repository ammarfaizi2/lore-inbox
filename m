Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKRJzk>; Mon, 18 Nov 2002 04:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSKRJzk>; Mon, 18 Nov 2002 04:55:40 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:22287 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261894AbSKRJzj>; Mon, 18 Nov 2002 04:55:39 -0500
Date: Mon, 18 Nov 2002 11:02:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-Reply-To: <20021118085928.82D7F2C30D@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211181054330.2109-100000@serv>
References: <20021118085928.82D7F2C30D@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Nov 2002, Rusty Russell wrote:

> And it *still* means you need two paths for your code: one for "I know
> it's not actually "active" yet, but I'm doing init and I need to
> access it anyway".  So every interface gains significant complexity by
> effectively implementing their own "live" flag...

Rusty, you know how refcounts work? Especially the "if 
(atomic_dec_and_test(&obj->ref)) cleanup(obj)" part is really interesting.

bye, Roman


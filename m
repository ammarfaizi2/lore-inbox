Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSKSABp>; Mon, 18 Nov 2002 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265010AbSKSABo>; Mon, 18 Nov 2002 19:01:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40722 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265008AbSKSABm>; Mon, 18 Nov 2002 19:01:42 -0500
Date: Mon, 18 Nov 2002 16:08:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alexander Viro <viro@math.psu.edu>, Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-Reply-To: <20021118235221.637162C456@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211181607120.13381-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, Rusty Russell wrote:
> 
> See other posting.  This is a fundamental design decision, and it's
> not changing.  Sorry.

Rusty, you take that approach, and the module code flies out of the 
kernel. 

The block device code (and a lot of other code) has been there happily 
forever. And not breaking drivers was part of the module loader rule. Now 
you seem to say that drivers should be broken een if they are perfectly 
fine and do not have any races as is.

If so, then bye bye new module loader.

		Linus


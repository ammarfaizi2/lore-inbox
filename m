Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSK0Hw1>; Wed, 27 Nov 2002 02:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSK0Hw1>; Wed, 27 Nov 2002 02:52:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19097 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261371AbSK0Hw1>;
	Wed, 27 Nov 2002 02:52:27 -0500
Date: Tue, 26 Nov 2002 23:58:10 -0800 (PST)
Message-Id: <20021126.235810.22015752.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Wed, 27 Nov 2002 18:42:28 +1100

   How's this one :-)
   
I don't think this is the way to go.

I think we really need to give the 32-bit compatability
types names and allow 64-bit arches to define what their
32-bit counterparts use.

For example, nlink_t is going to need to be different
for sparc 32-bit compat vs. most other platforms because
we use a signed short there.

Linus what is you big beef with the names used before, the "__kernel"
part of the name?  We can't just use "u32" for ino_t althroughout the
compat32 code or whatever your idea seems to be.

Please clarify.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUGOAGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUGOAGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUGOAGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:06:25 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:9173 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265886AbUGOAGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:06:23 -0400
Date: Thu, 15 Jul 2004 02:06:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715000608.GT974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714154427.14234822.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 03:44:27PM -0700, Andrew Morton wrote:
> If you end up pinning all of your ZONE_NORMAL pages with anonymous memory,
> further GFP_KERNEL allocation attempts will go oom.

exactly. Same problem happens with mlock on top of pagecache. (i.e. the
old 2.4 google bug)

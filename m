Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbTF2OVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTF2OVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:21:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17412 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265669AbTF2OVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:21:44 -0400
Date: Sun, 29 Jun 2003 16:35:42 +0200
From: Willy TARREAU <willy@w.ods.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Willy TARREAU <willy@w.ods.org>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629143542.GA372@pcw.home.local>
References: <20030629130952.GA246@pcw.home.local> <20030629141102.GE27348@parcelfarce.linux.theplanet.co.uk> <20030629142047.GA359@pcw.home.local> <20030629142725.GF27348@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629142725.GF27348@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 03:27:25PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 
> Sigh...  We _can't_ do that via chroot().  Please, stop fooling yourself -
> if attacker gets control over root process, the fight is over.  In particular,
> attacker can chmod your read-only directory and/or remount the thing.

not if the file-system is read-only by design (eg: romfs or anything like that)
or a read-only directory in /proc. To be honnest, I have another patch which
allows any process to chroot to /proc/self/empty. I know that it's not good
when the root is compromized. The attacker could do other things and even halt
the system. That's not what I'm trying to fight against. I'm only trying to
stop proliferation, and isolate the attacker into a place where the only tools
he can use are the ones he codes himself on the heap or stack, which is rather
limitating.

Cheers,
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbSKQVdH>; Sun, 17 Nov 2002 16:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSKQVdG>; Sun, 17 Nov 2002 16:33:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267604AbSKQVdF>; Sun, 17 Nov 2002 16:33:05 -0500
Date: Sun, 17 Nov 2002 13:40:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Doug Ledford <dledford@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Several Misc SCSI updates...
In-Reply-To: <20021117203823.GF3280@redhat.com>
Message-ID: <Pine.LNX.4.44.0211171338570.12975-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Doug Ledford wrote:
> 
> Won't work.  module->live is what Rusty uses to indicate that the module 
> is in the process of unloading, which is when we *do* want the attempt to 
> module_get() to fail.

That's fine, as long as "module_get()" is the only thing that cares. Just 
make it go "live" early as you indicate, and everybody should be happy. I 
certainly agree that it should be illegal to do more module_get()'s once 
we've already started unloading..

		Linus


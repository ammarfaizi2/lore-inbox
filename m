Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbSKQUWi>; Sun, 17 Nov 2002 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSKQUWe>; Sun, 17 Nov 2002 15:22:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267585AbSKQUWb>; Sun, 17 Nov 2002 15:22:31 -0500
Date: Sun, 17 Nov 2002 12:29:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Doug Ledford <dledford@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Several Misc SCSI updates...
In-Reply-To: <20021117202826.GE3280@redhat.com>
Message-ID: <Pine.LNX.4.44.0211171228350.1370-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Doug Ledford wrote:
>
> These bring the scsi subsys up to the new module loader semantics.  There 
> is more work to be done on inter-module locking here, but we need to solve 
> the whole module->live is 0 during init problem first or else it's a waste 
> of time.

Hey, just remove the "live" test, I think it's over-eager and likely to 
just cause extra code to work around it rather than fix anything.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUG2EYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUG2EYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 00:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUG2EYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 00:24:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38663 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264154AbUG2EYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 00:24:42 -0400
Date: Thu, 29 Jul 2004 06:18:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040729041811.GF1545@alpha.home.local>
References: <20040728124256.GA31246@devserv.devel.redhat.com> <20040728143634.0931ee07.akpm@osdl.org> <41081E8B.7030607@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41081E8B.7030607@candelatech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Wed, Jul 28, 2004 at 02:45:47PM -0700, Ben Greear wrote:
 
> In my opinion Becker's complaints were invalid, or maybe I just
> didn't understand what he was trying to say.  At any rate, lots of
> other NICs have supported larger MTUs and VLANs w/out problem, so
> it is unlikely that there is a fundamental flaw in accepting larger
> frames.

I've already used these cards with larger MTU to experiment some tunnelling
without decreasing the tunnel's MTU. I believe I used a NIC MTU around 1518
so that it could pass a cisco switch limited to 1536 bytes per frame. It
never went into production but it worked well.

> There are patches for tulip floating around too.  I have been running
> traffic on these patches for a while with no obvious problems
> (on 2.4 kernel, however).  Jeff, if you want me to re-send this to you,
> please let me know!

I noticed a bug in the 2.4 tulip driver concerning MTU. The parameter
is correctly declared as a static int, initialized with default values,
checked by the code, but not declared as MODULE_PARM, so the user cannot
change it ! I wanted to send a patch but didn't find time to work on it
yet. So if your vlan patch fixes it, it's welcome :-)

Cheers,
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJFNCS>; Sun, 6 Oct 2002 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJFNCS>; Sun, 6 Oct 2002 09:02:18 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:22033 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261584AbSJFNCR>; Sun, 6 Oct 2002 09:02:17 -0400
Date: Sun, 6 Oct 2002 09:07:52 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Patrikalakis <anrp@irulethe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PowerPC] Bug in IEEE1394 implementation on PowerBooks [Patch address]
Message-ID: <20021006130752.GF566@phunnypharm.org>
References: <20021006042003.4ED2F95E7F@irulethe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006042003.4ED2F95E7F@irulethe.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 09:20:03PM -0700, Andrew Patrikalakis wrote:
> 
> Hello again,
> 
> Since this is my first Linux patch, I'm not sure
> if what it does is OK, or even possible (but it
> works for me).
> 
> As this is kind of a specialist thing (FireWire
> on Apple laptops with Linux) I decided to put the
> patch on a web page:
> http://anrp.irulethe.net/powerbook-ieee1394.html
> 
> Anyone with this setup (Apple Pbook + firewire)
> please test this patch.

Checked your patch, but there are several problems with it.

For one, it only takes into account one OHCI1394 card being installed.
You'd be better of iterating over a list of all cards rather than
hardcoding one card, but that's moot given point 2.

Secondly, it seems that the problem doesn't really lie in ohci1394, but
that it actually has to do with the disk layer. From other usages of the
pmu interface, it seems that your best example is in drivers/scsi/mesh.c
and the change should be applied to sbp2.c.

If you need further help, you may want to talk to BenH (ppc maintainer).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

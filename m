Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVD0S0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVD0S0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVD0S0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:26:00 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:28546 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261934AbVD0SZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:25:31 -0400
Date: Wed, 27 Apr 2005 20:25:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427182528.GD4241@ucw.cz>
References: <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz> <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So yes the check fsuid is not the perfect solution.  However let me
> remind you that neither is the one with private namespace.

What I'm arguing about is that the fsuid check is obscure (it breaks
traditional semantics of file permissions [*], it doesn't allow an user
to grant access to his user mount to other users, even if the permissions
allow that and so on) and it doesn't fully solve the problem anyway.

For similar reasons, I don't advocate for private namespaces either.

The cure more likely lies in simple policy rules like the "all user mounts
belong to /mnt/usr" one, instead of putting dubious policy to the kernel.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Mr. Worf, scan that ship."  "Aye, Captain... 600 DPI?

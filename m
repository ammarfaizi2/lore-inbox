Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264325AbUDVP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUDVP4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUDVPzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:55:03 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:25349 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264188AbUDVPxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:53:10 -0400
Date: Thu, 22 Apr 2004 17:53:07 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse: fix mouse hotplugging
Message-ID: <20040422155307.GA14090@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404221044.56294.kim@holviala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404221044.56294.kim@holviala.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 10:44:56AM +0300, Kim Holviala wrote:
> Note to myself: make small patches not big confusing ones.
> 
> This patch fixes hotplugging of PS/2 devices on hardware which don't
> support hotplugging of PS/2 devices. In other words, most desktop machines.

 Is this needed? I frequently "hotplug" my trackball when 2.6 is forgeting
about it. Replugin make it work again, spitting in logs:

Apr 18 20:04:35 mother input.agent[30260]: ... no modules for INPUT product 
Apr 18 20:04:35 mother input.agent[30241]: ... no modules for INPUT product 
Apr 18 20:04:35 mother input.agent[30266]: ... no modules for INPUT product 11/2/5/0
Apr 18 20:04:35 mother kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Apr 18 20:04:37 mother udev[30307]: removing device node '/udev/input/mouse0'
Apr 18 20:04:37 mother udev[30309]: removing device node '/udev/input/event0'
Apr 18 20:04:38 mother udev[30312]: configured rule in '/etc/udev/udev.rules' at line 76 applied, 'mouse0' becomes 'input/%k'
Apr 18 20:04:38 mother udev[30312]: creating device node '/udev/input/mouse0'
Apr 18 20:04:38 mother udev[30313]: configured rule in '/etc/udev/udev.rules' at line 77 applied, 'event0' becomes 'input/%k'
Apr 18 20:04:38 mother udev[30313]: creating device node '/udev/input/event0'

-- 
Tomasz Torcz       ,,(...) today's high-end is tomorrow's embedded processor.''
zdzichu@irc.-nie.spam-.pl                      -- Mitchell Blank on LKML


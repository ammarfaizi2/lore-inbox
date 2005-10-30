Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJ3UCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJ3UCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJ3UCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:02:39 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:18405 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750717AbVJ3UCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:02:38 -0500
Date: Sun, 30 Oct 2005 12:02:19 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
Message-ID: <20051030200219.GB4794@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4363F31F.2040303@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29 2005, at 18:09, Jeff Garzik was caught saying:
> Deepak Saxena wrote:
> >There was some discussion on lkml on the subject of killing
> >the in-kernel driver and moving the whole implementation to
> >user space but that cannot be done as some SOCs (MPC85xx for
> >example) have the RNG unit as part of a larger device that
> >needs kernel space code to manage command descriptor rings
> >and other such things. We also want to be able to suspend/resume
> >the RNG devices (see OMAP driver) and that needs to be done as part
> >of the kernel PM path.
> 
> None of this precludes having this stuff in userspace.

I think moving it to user space will add more complexity for
the case where the HW unit is shared with an in in-kernel driver.
Instead of just having a simple char interface to read the data, 
it would require providing a facility for the user space code to 
add commands into the command linked list which seems like more
kernel code to me.

That being said, we can revisit that when actually writing the 
MPC85xx code.

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert

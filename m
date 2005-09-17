Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIQB1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIQB1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVIQB1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:27:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34698 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750814AbVIQB1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:27:49 -0400
Date: Sat, 17 Sep 2005 03:27:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Emmanuel Fleury <fleury@cs.aau.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
In-Reply-To: <432962B1.6040302@cs.aau.dk>
Message-ID: <Pine.LNX.4.61.0509170320000.3743@scrub.home>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.61.0509151253120.3743@scrub.home> <432962B1.6040302@cs.aau.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Emmanuel Fleury wrote:

> Why not directly having a direct reference to the name of the script ?
> 
> config FOO
> 	bool "foo"
> 	auto "detect-foo-script"
> 
> Where you have a specific directory in scripts/autoconfig/ where you
> store the scripts. Each script output y, n or m.

Unless there is an example, which really needs this, I don't think this is 
a good idea. Mainly because I don't like the idea of running random 
scripts during the config process, I prefer to keep this a little under 
control.

> This scheme seems much simpler to me (and yet not restrictive at all).
> Of course, each script might have to ask few questions to the user as:
> Do you want this FOO support ? [y/m/n]:

This will almost certainly not happen. The autoconfig rules would also be 
useful in the graphical config front ends and something like this would 
prevent it.

bye, Roman

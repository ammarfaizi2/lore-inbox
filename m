Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUHDE1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUHDE1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUHDE1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:27:10 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:13792 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264501AbUHDE1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:27:07 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091592870.5226.80.camel@gaston>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>
Content-Type: text/plain
Message-Id: <1091593555.3191.48.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 14:25:55 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 14:14, Benjamin Herrenschmidt wrote:
> > If you want to tell me how I
> > could tell it to quiesce without spin down, I'll happily do that.
> 
> Very easy... with the current code, just use state 4 for the round
> of suspend callbacks, ide-disk will then avoid spinning down.

Hmm. That's what I was doing and do do for the remainder of the devices.
Oh well. I'll give it a try again. What would 3 do? (There was a stage
when all three implementations used 3; I've just played sheep in
changing to 4).

It occurs to me that I'm going to need to extend the partial tree
handling anyway. When I get this working, I'm going to want to resume
only the storage devices, and haven't added code for that yet.

Regards,

Nigel


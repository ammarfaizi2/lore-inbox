Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTJIO0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTJIO0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:26:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33155 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262269AbTJIO0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:26:41 -0400
Date: Thu, 9 Oct 2003 16:26:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031009142632.GI1232@suse.de>
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com> <20031009140547.GD1232@suse.de> <20031009141734.GB23545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009141734.GB23545@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09 2003, Dave Jones wrote:
> On Thu, Oct 09, 2003 at 04:05:47PM +0200, Jens Axboe wrote:
> 
>  > > Red Hat just dropped this patch since it was suspected of data 
>  > > corruption ;-(
>  > Eh? Care to explain a bit further? I'm not aware of any data corruption
>  > issues there, and it's certainly simple enough to easily audit.
> 
> 3-4 cases of random data corruption, all using Quantum Fireball drives,
> all with different IDE chipsets.
> 
>  > And how kind of Red Hat to not inform me of any suspicion in this
>  > regard.
> 
> I want to get facts right before crying wolf.

Fair enough.

> Right now laptopmode/aam is just a suspect. There are still 1-2 other
> small patches against IDE which could be the reason.  We've dropped
> laptopmode/aam for the time being to see if the folks seeing repeatable
> corruption suddenly start behaving again.

aam patch is far more risky, it's a far more likely suspect. That patch
never reall did go out of beta. Dropping laptop-mode and aam at the same
time is bad engineering practice :).

laptop-mode cannot cause corruption that cannot show otherwise.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTKYOsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 09:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTKYOsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 09:48:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8838 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262694AbTKYOsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 09:48:50 -0500
Date: Tue, 25 Nov 2003 15:48:47 +0100
From: Jan Kara <jack@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031125144847.GA6748@atrey.karlin.mff.cuni.cz>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <20031124173527.GA1561@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124173527.GA1561@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Richard B. Johnson wrote:
> > To prevent this, a user can set his default permissions so that
> > neither group nor world can read the files. This is usually done
> > by setting the attributes in the user's top directory.
> 
> Correct, but the quota problem is genuine: what if I want to create a
> lot of files in /home/jamie that are readable by other users, but I
> want to be able to delete them at some later time and reuse my quota
> for something else?
> 
> This is quite a normal scenario on multi-user systems with quotas.
> 
> You seem to be suggesting that the only method is to have a separate
> partition for each user, which is absurd.
  I agree that malicious user can make some user run out of quotas
(actually he can do it even by more secret way by just opening the files
- but for this at least read permission is needed). But I guess that
reasonably capable admin discovers the problem and /bin/nologin as a
login shell solves the problem...

> Another method is "tree quotas" which have come up on this list
> before.  Hopefully they will be included one day; tree quotas seem
> like they would solve this problem and some others.
  Yes they would but denying hardlinks across 'quota trees' seems to be
the easiest way of making them technically possible and so you end up in
a similar situation as with some security patches...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

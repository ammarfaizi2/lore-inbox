Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTLCArv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLCArv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:47:51 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:47745 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264457AbTLCArs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:47:48 -0500
Date: Wed, 3 Dec 2003 00:47:36 +0000
From: Jamie Lokier <jamie@shareable.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031203004736.GB27306@mail.shareable.org>
References: <3FCB8312.3050703@rackable.com> <87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org> <877k1f9e1g.fsf@stark.dyndns.tv> <bqj41c$drr$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqj41c$drr$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> With O_SYNC files there is the possibility of having a don't cache bit
> in the packet to the drive, even with write caching. With fsync I don't
> see any way to do it after the fact for only some of the data in the
> drive cache. That's just an observation.

With fsync, can't you write all the dirty pages with that bit set,
write _again_ all the pages in RAM which are clean but which have
never been written with the don't-cache bit, and read-then-write with
the bit set all the pages which are not in RAM but which were dirtied
and written without the don't cache bit set?

I know, it sounds a bit complicated :)

But would it work?

-- Jamie

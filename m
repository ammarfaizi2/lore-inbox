Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUB2UjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 15:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUB2UjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 15:39:19 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:48852 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262135AbUB2UjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 15:39:17 -0500
Date: Sun, 29 Feb 2004 12:39:02 -0800
From: Paul Jackson <pj@sgi.com>
To: Joachim B Haga <c.j.b.haga@fys.uio.no>
Cc: peterw@aurema.com, miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
Message-Id: <20040229123902.35fd2404.pj@sgi.com>
In-Reply-To: <yydjishqw10p.fsf@galizur.uio.no>
References: <fa.fi4j08o.17nchps@ifi.uio.no>
	<fa.ctat17m.8mqa3c@ifi.uio.no>
	<yydjishqw10p.fsf@galizur.uio.no>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like we are trying to manage something worth managing,
which is how much of a systems CPU capacity is consumed by all
of a given users tasks over periods of minutes, by micromanaging
the scheduling of individual tasks over periods of ticks.

We don't manage disk space by telling someone no file bigger
than 1 megabyte.  Rather they get an upper limit on all their
files combined.  If they want to spend most of that on one
file, that's fine.

Is there anyway to provide a mechanism that would support
administering a system as follows:

  1) Users get so much CPU usage allowed, determined by an upper
     limit on a running average of the combined CPU usage of all
     their tasks, with a half life perhaps on the order of minutes.

  2) They can nice their tasks up and down, within a decent range,
     as they will.

  3) But if they push too close to their allowed limit, all
     their tasks get reined in.  The relative priorities within
     their own tasks are not changed, but the priority of their
     tasks relative to other users is weakened.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWF0QTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWF0QTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWF0QTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:19:05 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:8463 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1161153AbWF0QTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:19:03 -0400
Message-ID: <20060627201901.B18563@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 20:19:01 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <20060626200225.GA5330@MAIL.13thfloor.at> <20060627130911.A13959@castle.nmd.msu.ru> <20060627154818.GA28984@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20060627154818.GA28984@MAIL.13thfloor.at>; from "Herbert Poetzl" on Tue, Jun 27, 2006 at 05:48:19PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

On Tue, Jun 27, 2006 at 05:48:19PM +0200, Herbert Poetzl wrote:
> On Tue, Jun 27, 2006 at 01:09:11PM +0400, Andrey Savochkin wrote:
> > 
> > On Mon, Jun 26, 2006 at 10:02:25PM +0200, Herbert Poetzl wrote:
> > > 
> > >  - traffic between guests
> > >    can be as high (or even higher) than the
> > >    outbound traffic, just think web guest and
> > >    database guest
> > 
> > My experience with host-guest systems tells me the opposite: outside
> > traffic is a way higher than traffic between guests. People put web
> > server and database in different guests not more frequent than they
> > put them on separate physical server. Unless people are building a
> > really huge system when 1 server can't take the whole load, web and
> > database live together and benefit from communications over UNIX
> > sockets.
> 
> well, that's probably because you (or your company)
> focuses on providers which simply (re)sell the entities
> to their customers, in which case it would be more
> expensive to put e.g. the database into a separate
> guest. but let me state here that this is not the only
> application for this technology

I'm just sharing my experience.
You have one experience, I have another, and your classification of traffic
importance is not the universal one.
My point was that we shouldn't overestimate the use of INET sockets vs. UNIX
ones in configurations where communications but not web/db operations play a
big role in overall performance.
And indeed I've talked with many different people, from universities to
large enterprises.

> 
[snip]
> > I'd like to caution about over-optimizing communications between
> > different network namespaces. Many optimizations of local traffic
> > (such as high MTU) don't look so appealing when you start to think
> > about live migration of namespaces.
> 
> I think the 'optimization' (or to be precise: desire
> not to sacrifice local/loopback traffic for some use
> case as you describe it) does not interfere with live
> migration at all, we still will have 'local' and 'remote'
> traffic, and personally I doubt that the live migration
> is a feature for the masses ...

Why not for the masses?

	Andrey

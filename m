Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285390AbRLGDTo>; Thu, 6 Dec 2001 22:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285394AbRLGDTf>; Thu, 6 Dec 2001 22:19:35 -0500
Received: from bergeron.research.canon.com.au ([203.12.172.124]:13104 "HELO
	a.mx.canon.com.au") by vger.kernel.org with SMTP id <S285390AbRLGDTW>;
	Thu, 6 Dec 2001 22:19:22 -0500
Date: Fri, 7 Dec 2001 14:19:13 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011207141913.A26225@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0EE8DD.3080108@namesys.com>; from reiser@namesys.com on Thu, Dec 06, 2001 at 06:41:17AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser <reiser@namesys.com> wrote:
| Have you ever seen an application that creates millions of files create 
| them in random order?

I can readily imagine one. An app which stashes things sent by random
other things (usenet/email attachment trollers? security cameras taking
thouands of still photos a day?). Mail services like hotmail. with a
zillion mail spools, being made and deleted and accessed at random...

|  Applications that create millions of files are usually willing to play 
| nice for an order of magnitude performance gain also.....

But they shouldn't have to! Specificly, to "play nice" you need to know
about the filesystem attributes. You can obviously do simple things like
a directory hierachy as for squid proxy caches etc, but it's an ad hoc
thing. Tuning it does require specific knowledge, and the act itself
presumes exactly the sort of inefficiency in the fs implementation that
this htree stuff is aimed at rooting out.

A filesystem _should_ be just a namespace from the app's point of view.
Needing to play silly subdir games is, well, ugly.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Were I subject to execution, I would choose to be fired at tremendous
speed from a cannon into the brick wall of an elemetary school building,
and insist on full media coverage, however, as I said the choices are
sadly limited.	- Jim Del Vecchio

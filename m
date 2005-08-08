Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVHHKUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVHHKUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVHHKUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:20:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:927 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750805AbVHHKUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:20:30 -0400
Date: Mon, 8 Aug 2005 12:20:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050808102022.GA17978@wohnheim.fh-wedel.de>
References: <20050802071828.GA11217@redhat.com> <84144f0205080223445375c907@mail.gmail.com> <20050808095747.GD13951@redhat.com> <1123495525.3245.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1123495525.3245.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 August 2005 12:05:25 +0200, Arjan van de Ven wrote:
> On Mon, 2005-08-08 at 17:57 +0800, David Teigland wrote:
> > > 
> > > Please drop the extra braces.
> > 
> > Here and elsewhere we try to keep unused stuff off the stack.  Are you
> > suggesting that we're being overly cautious, or do you just dislike the
> > way it looks?
> 
> nice theory. In practice gcc 3.x still adds up all the stack space
> anyway and as long as gcc 3.x is a supported kernel compiler, you can't
> depend on this. Also.. please favor readability. gcc is getting smarter
> about stack use nowadays, and {}'s shouldn't be needed to help it, it
> tracks liveness of variables already.

Plus, you don't have to guess about stack usage.  Run "make
checkstack" or, better yet, run the objdump of fs/gfs/built-in.o
through the perl script.

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSLFMlp>; Fri, 6 Dec 2002 07:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSLFMlp>; Fri, 6 Dec 2002 07:41:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18897 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262322AbSLFMlo>; Fri, 6 Dec 2002 07:41:44 -0500
Date: Fri, 6 Dec 2002 10:48:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Norman Gaywood <norm@turing.une.edu.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
In-Reply-To: <20021206122753.A8992@turing.une.edu.au>
Message-ID: <Pine.LNX.4.50L.0212061047180.22252-100000@duckman.distro.conectiva>
References: <mailman.1039133948.27411.linux-kernel2news@redhat.com>
 <200212060035.gB60ZnV07386@devserv.devel.redhat.com> <20021206122753.A8992@turing.une.edu.au>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Norman Gaywood wrote:
> On Thu, Dec 05, 2002 at 07:35:49PM -0500, Pete Zaitcev wrote:

> > Check your /proc/slabinfo, just in case, to rule out a leak.
>
> Here is a /proc/slabinfo diff of a good system and a very sluggish one:

> > inode_cache       305071 305081    512 43583 43583    1 :  124   62
> > buffer_head       3431966 3432150    128 114405 114405    1 :  252  126

Guess what ?  120 MB in inode cache and 450 MB in buffer heads,
or 570 MB of zone_normal eaten with just these two items.

Looks like the RH kernel needs Stephen Tweedie's patch to
reclaim the buffer heads once IO is done ;)

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?
http://www.surriel.com/		http://guru.conectiva.com/

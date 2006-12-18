Return-Path: <linux-kernel-owner+w=401wt.eu-S1754721AbWLRWpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbWLRWpW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbWLRWpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:45:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53429 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbWLRWpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:45:20 -0500
Date: Mon, 18 Dec 2006 14:45:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
cc: andrei.popa@i-neo.ro, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <5a4c581d0612181400t347fc9efx69e55efb3ef40c45@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612181434210.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>  <1166476297.6862.1.camel@localhost>
 <5a4c581d0612181400t347fc9efx69e55efb3ef40c45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Alessandro Suardi wrote:
> 
> No idea whether this can be a data point or not, but
> here it goes... my P2P box is about to turn 5 days old
> while running nonstop one or both of aMule 2.1.3 and
> BitTorrent 4.4.0 on ext3 mounted w/default options
> on both IDE and USB disks. Zero corruption.
> 
> AMD K7-800, 512MB RAM, PREEMPT/UP kernel,
> 2.6.19-git20 on top of up-to-date FC6.

It _looks_ like PREEMPT/SMP is one common configuration.

It might also be that the blocksize of the filesystem matters. 4kB 
filesystems are fundamentally simpler than 1kB filesystems, for example. 
You can tell at least with "/sbin/dumpe2fs -h /dev/..." or something.

Andrei - one thing that might be interesting to see: when corruption 
occurs, can you get the corrupted file somehow? And compare it with a 
known-good copy to see what the corruption looks like?

		Linus

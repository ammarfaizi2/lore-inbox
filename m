Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWGXGtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWGXGtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 02:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWGXGtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 02:49:55 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:55424 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751424AbWGXGtz
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 24 Jul 2006 02:49:55 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17604.27801.796726.164279@gargle.gargle.HOWL>
Date: Mon, 24 Jul 2006 10:45:45 +0400
To: "Joshua Hudson" <joshudson@gmail.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links
Newsgroups: gmane.linux.kernel
In-Reply-To: <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
References: <6ARGK-19L-5@gated-at.bofh.it>
	<6B8og-1iB-17@gated-at.bofh.it>
	<E1G4Kpi-0001Os-AK@be1.lrz>
	<bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000016 15cc343f08d9c65fb0652e12e785aa62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson writes:
 > On 7/22/06, Bodo Eggert <7eggert@elstempel.de> wrote:
 > > Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
 > >
 > > > Joshua Hudson <joshudson@gmail.com> wrote:
 > > >> This patch is the sum total of all that I had to change in the kernel
 > > >> VFS layer to support hard links to directories
 > > >
 > > > Can't be done, as it creates the possibility of loops.
 > >
 > > Don't do that then?
 > Exactly.
 > 
 > > > Detecting unconnected subgraphs uses a /lot/ of memory; and much worse, you
 > > > have to stop (almost) all filesystem activity while doing it.
 > I know.
 > 
 > I just decided the price is worth it.
 > 
 > In my filesystem, any attempt to create a loop of hard links
 > is detected and cancelled. 

Can you elaborate a bit on this exciting mechanism? Obviously an ability
to efficiently detect loops would be a break-through in a
reference-counted garbage collection, somehow missed for last 40
years. :-)

 >                            Unlinking a directory requires it
 > to be empty if the last link is being removed. "." and ".."
 > links are counted separately from real links, so that is easy.

Nikita.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVCaGzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVCaGzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVCaGzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:55:44 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:27145 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262506AbVCaGzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:55:35 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Cc: 20050323135317.GA22959@roonstrasse.net, linux-kernel@vger.kernel.org
In-Reply-To: <6f6293f105033015467d87993@mail.gmail.com>
References: <20050328172820.GA31571@linux.ensimag.fr>
	 <6f6293f105033015467d87993@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 08:55:33 +0200
Message-Id: <1112252134.26074.20.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 01:46 +0200, Felipe Alfaro Solana wrote:
> On Mon, 28 Mar 2005 19:28:20 +0200, Matthieu Castet
> <mat@ensilinx1.imag.fr> wrote:
> > > The memory limits aren't good enough either: if you set them low
> > > enough that memory-forkbombs are unperilous for
> > > RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
> > > applications.
> > 
> > yes, if you want to run application like openoffice.org you need at
> > least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...
> > 
> > I think per user limit could be a solution.
> > 
> > attached a small fork-memory bombing.
> 
> Doesn't do anything on my machine:
> 
> # ulimits -a
...

> it tops at 100 processes and eats a little CPU... although the system
> is under load, it's completely responsive.

100 processes is low. I often have over 150.

I use the patch mentioned here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111209980932023&w=2
(it set the default max_threads and RLIMIT_NPROC to half of the current
default)

and my system survived.

ncopa@nc ~ $ ulimit -u
4093

(I have 1 GiB RAM)

--
Natanael Copa



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTGHRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTGHRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:07:58 -0400
Received: from dnsc6804027.pnl.gov ([198.128.64.39]:43649 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264898AbTGHRH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:07:57 -0400
Date: Tue, 8 Jul 2003 10:22:25 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andi Kleen <ak@suse.de>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
Message-ID: <20030708102225.D4482@schatzie.adilger.int>
Mail-Followup-To: Andi Kleen <ak@suse.de>, bzzz@tmi.comex.ru,
	linux-kernel@vger.kernel.org
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel> <p73brw5qmxk.fsf@oldwotan.suse.de> <87of05ujfo.fsf@gw.home.net> <20030708134601.7992e64a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708134601.7992e64a.ak@suse.de>; from ak@suse.de on Tue, Jul 08, 2003 at 01:46:01PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 08, 2003  13:46 +0200, Andi Kleen wrote:
> On Tue, 08 Jul 2003 15:28:27 +0000 bzzz@tmi.comex.ru wrote:
> > dynlocks implements 'lock namespace', so you can lock A for namepace N1 and
> > lock B for namespace N1 and so on. we need this because we want to take lock
> > on _part_ of directory.
> 
> Ok, a mini database lock manager. Wouldn't it be better to use a small hash 
> table and lock escalation on overflow for this?  Otherwise you could
> have quite a lot of entries queued up in the list if the server is slow.

That was my initial thought also, but the number of locks that are in
existence at one time are very small (i.e. number of threads active in
a directory at one time).  Having a "more scalable" locking setup will,
I think, hurt performance for the common case.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


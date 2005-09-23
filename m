Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVIWOYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIWOYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVIWOYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:24:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56250 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751016AbVIWOYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:24:30 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050923084529.GD10859@x30.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923084529.GD10859@x30.random>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 09:24:26 -0500
Message-Id: <1127485466.9097.16.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 10:45 +0200, Andrea Arcangeli wrote:
> On Fri, Sep 23, 2005 at 03:20:33AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 23 Sep 2005 10:36:16 +1000, Con Kolivas said:
> > 
> > (Adding Andrea to the To: list...)
> > 
> > > On Fri, 23 Sep 2005 05:59, Valdis.Kletnieks@vt.edu wrote:
> > > > Am seeing reproducible wedging up when writing large (20M+) files to an
> > > > ext3 file system.  Oddly enough, if something *else* writes files to the
> > > > file system as well, it will unwedge for a while and make progress.  Also,
> 
> So you get a total hang? I guess there's a bug somewhere...

I get a similar hang running fsx on a jfs file system.
"echo 0 > /proc/sys/vm/dirty_ratio_centisecs" fixes it as well.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


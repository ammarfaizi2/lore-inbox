Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbTGJOZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbTGJOZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:25:46 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:44531 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S269285AbTGJOZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:25:44 -0400
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
From: Martin Schlemmer <azarah@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nikita Danilov <Nikita@Namesys.COM>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709034251.6902c488.akpm@osdl.org>
References: <16139.54887.932511.717315@laputa.namesys.com>
	 <20030709031203.3971d9b4.akpm@osdl.org>
	 <16139.60502.110693.175421@laputa.namesys.com>
	 <20030709034251.6902c488.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057848055.1164.311.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Jul 2003 16:40:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 12:42, Andrew Morton wrote:
> Nikita Danilov <Nikita@Namesys.COM> wrote:
> >
> >  > OK, fixes a bug.
> > 
> >  What bug?
> 
> Failing to consider mapped pages on the active list until the scanning
> priority gets large.
> 
> I ran up your five patches on a 256MB box, running `qsbench -m 350'.  It got
> all slow then the machine seized up.   I'll poke at it some.
> 

P4 2.4HT with 1GB of ram - could be me, but things seem to start a
tad quicker.  If I however push it with two 'make -j12' compiles that
normally works fine, it goes for about 10-15mins, and then OOM killer
kills X, evo, galeon, etc.

Must note that for most of the time free memory stays in the region of
450-650mb and then suddenly things goes for the worse.  Also, after this
there is only about 80MB used ...  If I then start X, etc again, same
thing after 10-15 mins - the box thus never died, just suddenly all free
memory was taken.

If you need any stats, etc, let me know.

BTW, kernel is 2.5.74-bk7.


Regards,

-- 
Martin Schlemmer



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTHTRvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbTHTRvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:51:01 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55821 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262074AbTHTRu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:50:59 -0400
Date: Wed, 20 Aug 2003 13:50:54 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Clean kernel patch for LEON/SPARC
Message-ID: <20030820135054.E6511@devserv.devel.redhat.com>
References: <3F43551A.1060901@gaisler.com> <20030820123311.A6511@devserv.devel.redhat.com> <3F43B061.3010805@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F43B061.3010805@gaisler.com>; from jiri@gaisler.com on Wed, Aug 20, 2003 at 07:31:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 20 Aug 2003 19:31:13 +0200
> From: Jiri Gaisler <jiri@gaisler.com>

> > Did you guys figure out the cause of the severe problem
> > with cache corruption?
> 
> Yes, this was a virtual address aliasing problem. Leon2 has
> virtual caches but the MMU has no aliasing detection, so we
> are forced to flush the cache on each task switch. Our next
> processor (leon3) will have to switch to either physical caches
> or have some form of aliasing detection ...

Physical cache is always welcome, but I'm wondering if it's
really that needed, as you're not doing SMP. Do you have
the Schimmel's book?

-- Pete

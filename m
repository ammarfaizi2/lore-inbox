Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVBSGBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVBSGBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVBSGBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:01:43 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:39093 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261640AbVBSGBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:01:41 -0500
Subject: Re: [RFC][PATCH] Dynamically allocated pageflags.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1108792304.19253.12.camel@localhost>
References: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
	 <1108782127.19253.4.camel@localhost>
	 <1108784122.4077.123.camel@desktop.cunningham.myip.net.au>
	 <1108792304.19253.12.camel@localhost>
Content-Type: text/plain
Message-Id: <1108793012.4098.0.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 17:03:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-02-19 at 16:51, Dave Hansen wrote:
> On Sat, 2005-02-19 at 14:35 +1100, Nigel Cunningham wrote:
> > On Sat, 2005-02-19 at 14:02, Dave Hansen wrote:
> > > One issue is that it doesn't work with DISCONTIGMEM (or the upcoming
> > > sparsemem).  max_mapnr doesn't exist on those systems, and on the really
> > > discontiguous ones, you might be allocating very large areas with very
> > > sparse maps.
> > 
> > :> Am I right in thinking that just requires something similar, done
> > per-zone? If that's the case, I'll happily modify the code to suit. I
> > should support discontig anyway in suspend.
> 
> The mem_maps are per-pgdat or per-node with discontig, but I have a
> patch in the pipeline to take them out of there and make one for every
> 128MB or 256MB, etc... area of memory (for memory hotplug).  So, hanging
> them off the pgdat or zone won't even work in that case, because even
> the struct zone can have pretty sparse memory inside of it.  I *think*
> the table is the only way to go.  But, that can wait until Monday. :)

Okay. I'll just wait :>

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574


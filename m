Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDXHpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTDXHpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:45:39 -0400
Received: from pointblue.com.pl ([62.89.73.6]:53262 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261605AbTDXHpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:45:18 -0400
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1051169958.3604.2619.camel@workshop.saharact.lan>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
	 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
	 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
	 <20030421210020.A29421@lst.de>
	 <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
	 <20030421215637.A30019@lst.de>
	 <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
	 <1050957875.1224.2.camel@flat41>
	 <1051169958.3604.2619.camel@workshop.saharact.lan>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051171042.1104.11.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 08:57:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 08:39, Martin Schlemmer wrote:
> On Mon, 2003-04-21 at 22:44, Grzegorz Jaskiewicz wrote:
> 
> > to use devfs only, it is funny but fe to open /dev/sound/* you need to
> > be root, or chmod it manually before use. (i've got seperate
> > /etc/init.d/chdevfsmod file to do that)
> > 
> 
> Add to /etc/devfsd.conf:
> 
> -----------------------------
> REGISTER        sound/.*     PERMISSIONS root.audio 660
> REGISTER        snd/.*       PERMISSIONS root.audio 660
> -----------------------------


Well, if you will read my post - i am trying to use _ONLY_ devfs,
without any demons. Those demons are provided just to keep backward
compatbility (at least this is my opinion) and can be used without them.

i don't like personaly any ideas about udevfs and others. We should get
rid of min/maj nr of each device becouse each single program uses device
by name indeed ! Having just devfs solves many problems and is very good
thing. But, again - without any userspace demons.

Linus was always trying kernel as simple as it is possible, well - imho
devfs is just one step forward to make it even simpler but without
removing any of it functionality.

 

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs


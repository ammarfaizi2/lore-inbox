Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDXHbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDXHbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:31:53 -0400
Received: from [196.41.29.142] ([196.41.29.142]:1019 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261323AbTDXHbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:31:52 -0400
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
From: Martin Schlemmer <azarah@gentoo.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Pavel Roskin <proski@gnu.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1050957875.1224.2.camel@flat41>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
	 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
	 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
	 <20030421210020.A29421@lst.de>
	 <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
	 <20030421215637.A30019@lst.de>
	 <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
	 <1050957875.1224.2.camel@flat41>
Content-Type: text/plain
Organization: 
Message-Id: <1051169958.3604.2619.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 24 Apr 2003 09:39:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 22:44, Grzegorz Jaskiewicz wrote:

> to use devfs only, it is funny but fe to open /dev/sound/* you need to
> be root, or chmod it manually before use. (i've got seperate
> /etc/init.d/chdevfsmod file to do that)
> 

Add to /etc/devfsd.conf:

-----------------------------
REGISTER        sound/.*     PERMISSIONS root.audio 660
REGISTER        snd/.*       PERMISSIONS root.audio 660
-----------------------------

Or whatever perms you wish ...


Regards,

-- 
Martin Schlemmer



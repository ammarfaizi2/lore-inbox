Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271040AbTGPSNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTGPSMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:12:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30411
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271033AbTGPSJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:09:56 -0400
Subject: Re: PS2 mouse going nuts during cdparanoia session.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716173122.GQ833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de>
	 <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
	 <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de>
	 <20030716172531.GP833@suse.de> <20030716172823.GE21896@suse.de>
	 <20030716173122.GQ833@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058379733.6633.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 19:22:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 18:31, Jens Axboe wrote:
> Doesn't look really bogged down by interrupt load, still half idle. So
> that looks like a PS2 bug. Unless the irq latencies are really bad, I
> guess that could be it too. Vojtech knows a hell of a lot more about
> that than me :)

PS/2 has some horrble timing rules but they are the wrong way around for this
bug so I'm somewhat baffled - you must do 1mS sized delays between ps/2 
reads even on some current chipsets but there isnt really an upper limit


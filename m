Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTGQLCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271412AbTGQLCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:02:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11726
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271411AbTGQLCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:02:41 -0400
Subject: Re: PS2 mouse going nuts during cdparanoia session.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716234711.GA22010@ucw.cz>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de>
	 <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
	 <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de>
	 <20030716190018.GE20241@ucw.cz> <20030716193002.GA2900@suse.de>
	 <20030716205319.GA20760@ucw.cz> <20030716233124.GA16209@suse.de>
	 <20030716234711.GA22010@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058440490.8620.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 12:15:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave just a random pondering looking over the code - does it make any
difference if you stick a udelay(50) at the top of wait_read and
wait_write in i8042.c. Right now we don't always seem to honour the
delays for certain specific patterns of I/O and interrupt.

Ditto the read_status/read_data loop in the _interrupt code path.


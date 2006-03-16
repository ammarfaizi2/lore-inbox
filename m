Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWCPBoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWCPBoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWCPBoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:44:04 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:6367
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751844AbWCPBoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:44:02 -0500
Message-ID: <4418C26A.5010001@microgate.com>
Date: Wed, 15 Mar 2006 19:42:02 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6: known regressions
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>	 <20060313200544.GG13973@stusta.de>  <20060313144244.266d96ef.akpm@osdl.org> <1142374716.3623.23.camel@localhost.localdomain>
In-Reply-To: <1142374716.3623.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-13 at 14:42 -0800, Andrew Morton wrote:
> 
>>Post-<tty changes, perhaps>
>>  From: "Bob Copeland" <bcopeland@gmail.com>
>>  Subject: 2.6.16-rc5 pppd oops on disconnects
> 
> 
> Possibly although from an initial look I didn't see anything that
> explained it and I still do see a lot of problems with USB serial and
> USB error handling that might be USB or serial but predate the changes.

GregKH just snuffed this one with a tweak to sysfs.
It was a convoluted interaction of usb/tty/sysfs
which was only revealed with slab debug and unplugging
the usb device in an active tty session.

--
Paul

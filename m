Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWCNWkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWCNWkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:40:16 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:54192
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751944AbWCNWkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:40:14 -0500
Message-ID: <441745D0.1040508@microgate.com>
Date: Tue, 14 Mar 2006 16:38:08 -0600
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

This has been isolated to a USB and/or cdc-acm driver problem
and has nothing to do with the tty changes or ppp.

It appears to be a reference counting error resulting in
a released dev object that is passed to sysfs.
We are making progress, and expect some more info
tonight from Bob. Fortunately the error is repeatable
even if the actual error is obscure.

--
Paul

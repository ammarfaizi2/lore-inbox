Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWHNPl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWHNPl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWHNPl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:41:56 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:40408 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1750912AbWHNPlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:41:55 -0400
Message-ID: <44E099BF.8050101@mauve.plus.com>
Date: Mon, 14 Aug 2006 16:41:51 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with latest kernels
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net> <44E09190.1040505@mauve.plus.com> <200608141119.05558.gene.heskett@verizon.net>
In-Reply-To: <200608141119.05558.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Monday 14 August 2006 11:06, Ian Stirling wrote:
>> Gene Heskett wrote:
>> <snip>
>>
>>> I'm having similar problems with an HP Pavilian dv5220, and with a
>>> bluetooth mouse dongle plugged into the right side usb port it works
>>> just fine.  What I'd like to do is totally disable that synaptics pad
>>> as its way too sensitive, making it impossible to type more than a line
>>> or 2
>> Enable the proper USB options, point X/GPM to /dev/input/mouse1 - or
>> whatever.
> 
> Please describe how to do this and it will be done forthwith.

Actually - I think it should be stock.
Try cat /dev/input/mouse0 - and moving the mouse/trackpad. if this 
generates random text, then you're done.
/dev/input/mice is a fake device that globs all the mice in the system 
together.
/dev/input/mouse[n] is the nth mouse on the system.
Also - you can just go to device drivers/input - and disable the ps/2 
mouse driver.
Set up X and GPM to use /dev/input/mouse1 - if this is your USB mouse, 
and it just works.

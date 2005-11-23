Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVKWT4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVKWT4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKWT4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:56:34 -0500
Received: from kirby.webscope.com ([204.141.84.57]:50669 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932267AbVKWT4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:56:33 -0500
Message-ID: <4384C909.4040107@m1k.net>
Date: Wed, 23 Nov 2005 14:54:49 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <20051123174237.GO3963@stusta.de> <4384C059.3070003@m1k.net> <200511231436.54136.gene.heskett@verizon.net>
In-Reply-To: <200511231436.54136.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 23 November 2005 14:17, Michael Krufky wrote:
>
>[...]
>
>>f it fixes Gene's problem (a quick glance at his emails suggests that
>>it does) then:
>>    
>>
>Read further Michael, it still takes a _cold_ reboot to 2.6.14.2 to fix
>it.
>
I'm sorry -- I should have been clearer... It fixes the following error 
message, correct?

Gene Heskett wrote:

> WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb
> .ko needs unknown symbol nxt200x_attach.

About the cold reboot needed for 2.6.14.2, well, that is completely 
unrelated...

First, does the patch fix the unknown symbol error?  If so, then the 
patch is correct.

Moving on........

Kirk Lapray wrote both OR51132 and NXT200X frontend modules (cc added) ...

First off, Gene, I am still under the impression that both v4l and dvb 
subsystems are broken under 2.6.15 due to the memory bugs... I don't 
know if Hugh Dickins fixed those yet or not.

Please try to build merged v4l+dvb cvs trees against your 2.6.14.2 
kernel, and tell me if you are having the same problems.  If you are 
indeed having the same problem, then it confirms that something in the 
nxt200x module is causing problems in the OR51132 module.

Kirk, are you able to use both modules together using both pcHDTV and 
ATI HDTV Wonder PCI cx88 boards simultaneously without causing any 
conflicts?

Once again, Gene, please follow the tree-merge instructions located at:

http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

Please let me know if the problem persists.  If the problem is gone, 
then nxt200x is a red herring.

Regards,

Michael Krufky



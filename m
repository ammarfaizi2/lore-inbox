Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUAMQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAMQkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:40:25 -0500
Received: from main.gmane.org ([80.91.224.249]:60896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264366AbUAMQkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:40:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 16:40:05 +0100
Organization: University of the Armed Forces, Hamburg, Germany
Message-ID: <bu13gl$rs2$1@sea.gmane.org>
References: <2867040.OKCKYgd4AF@spamfreemail.de> <400329AE.8050304@cyberone.com.au> <3411792.vcVGz9Xbqa@spamfreemail.de> <200401131534.53423.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>> I have found a (perhaps THE) reason why my X is so jerky: the nforce2
>> chipset driver (amd74xx) doesn't load, because it "thinks" the BIOS IDE
>> ports are disabled - which is definitely not the case
> 
> It doesn't load because IDE ports are already controlled by generic IDE
> code.
> Just use CONFIG_BLK_DEV_AMD74XX=y.  I will fix this "BIOS" comment.

I can't, because I (plan to) use this kernel on many different machines. Not
all of those (in fact: only one) uses the amd74xx module.

Is there a kernel parameter I can use to disable the generic IDE code on
boot?
I already tried compiling without CONFIG_BLK_DEV_GENERIC, which doesn't
help.


Thanks!

-- 
Jens Benecke (jens at spamfreemail.de)
Please DO NOT CC: me.
 
http://www.hitchhikers.de - Europaweite kostenlose Mitfahrzentrale
http://www.spamfreemail.de - 100% saubere Postfächer - garantiert!
http://www.rb-hosting.de - PHP ab 9? - SSH ab 19? - günstiger Traffic


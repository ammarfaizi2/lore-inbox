Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbTHTCsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTHTCsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:48:18 -0400
Received: from main.gmane.org ([80.91.224.249]:58840 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261551AbTHTCsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:48:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: Can't read fan-speeds from i2c
Date: Tue, 19 Aug 2003 22:48:14 -0400
Message-ID: <3F42E16E.8070809@ghz.cc>
References: <1061324213.708.6.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <1061324213.708.6.camel@chevrolet.hybel>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet wrote:
> I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> seems to work as it is supposed to, except for fan-speeds. They say 0.
> Is that supposed behaviour since the as99127f doesn't have any
> datasheets, or am I doing something wrong?

Have you tried adjusting the fan divisors (fan_div* in 
/sys/bus/i2c/devices/*)? Keep multiplying the fan divisor by two, and 
check the fan_input* devices-- you may have slow fans (or divide-by-two 
speed sensors), and you might need a longer sampling interval to see the 
lower speed.

Another option is to start the Windows monitoring program, perform a 
warm reboot into Linux, and use i2cdump to see how they configured the 
registers. Be sure to prevent your i2c drivers from loading, as a number 
of them initialize the chips to default settings.

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/



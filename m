Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTH1Cdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTH1Cdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:33:49 -0400
Received: from main.gmane.org ([80.91.224.249]:62888 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261885AbTH1Cds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:33:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: HZ and C2 idling [was: Re: [DRIVER 2.6] amd76x_pm rediffed for 2.6.0-test4]
Date: Wed, 27 Aug 2003 22:33:51 -0400
Message-ID: <bijpma$85j$1@sea.gmane.org>
References: <slrnbkq1mj.eu5.psavo@varg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <slrnbkq1mj.eu5.psavo@varg.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using this patch for some time now. At HZ=1000, I had to set 
tick=10200 or more to keep ntpd happy (even with the PM timer as a time 
source).

I broke down and changed HZ to 100, and it seems to be holding steady 
(still with the PM timer, though). This leads me to believe that the C2 
idle/resume process takes longer than 1 ms in the worst case.

Wasn't there a patch pending to allow HZ to be changed via the config 
interface?

-C




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTDGWbe (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTDGWbe (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:31:34 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:49319 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S263726AbTDGWbd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:31:33 -0400
Message-ID: <3E91FEF8.20207@cox.net>
Date: Mon, 07 Apr 2003 15:43:04 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv> <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv> <b6s3tm$i2d$1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv> <Pine.LNX.4.44.0304072351110.12110-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0304072351110.12110-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>>Consequently it's impossible that the kernel guarantees a static name/ 
>>number for a specific device. devfs showed that the kernel is the wrong 
>>place for name policies. Is see no other possibility than to number 
>>devices dynamically and leave it to userspace to name them or did I miss 
>>an important point in previous discussions?
>>Maybe you could also answer me, what exactly you need a 64bit dev_t for?

Well, I'm not Peter, or Andries or anyone else for that matter... but if a 
userspace tool can be built that will enforce the user's (or distro's) desired 
naming policies for completely dynamic numbered devices, I'm all for that. It 
sure seems that it would greatly simplify much code in the kernel and completely 
eliminate the need to move beyond 32-bit dev_t at all. (I mean really, who's 
ever going to have more than 4G devices on a single Linux system image?)

However, there are significant hurdles to implementing this tool:

- defining an adequately powerful file format to define the desired naming policy
- getting the tool to run _both_ in early-userspace and real-userspace 
environments, using the _same_ policy file (or copies thereof)


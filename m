Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWBWSAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWBWSAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWBWSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:00:15 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:42730 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932380AbWBWSAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:00:13 -0500
Message-ID: <43FDF82A.5050201@bootc.net>
Date: Thu, 23 Feb 2006 18:00:10 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: MD Raid 6: poor algorithm choice?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[4295106.360000] raid6: int32x1    714 MB/s
[4295106.381000] raid6: int32x2    742 MB/s
[4295106.403000] raid6: int32x4    632 MB/s
[4295106.429000] raid6: int32x8    523 MB/s
[4295106.453000] raid6: mmxx1     1476 MB/s
[4295106.474000] raid6: mmxx2     2500 MB/s
[4295106.500000] raid6: sse1x1    1375 MB/s
[4295106.521000] raid6: sse1x2    2339 MB/s
[4295106.524000] raid6: using algorithm sse1x2 (2339 MB/s)
[4295106.531000] md: raid6 personality registered for level 6

I just loaded the raid6 module for fun (might end up using it one day), and I 
was surprised at its choice of algorithm. By the messages above, I would have 
assumed it would choose the mmxx2 algorithm at 2500 MB/s instead of sse1x2 at 
the slightly slower 2339 MB/s. This is probably entirely expected behaviour, but 
why?

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

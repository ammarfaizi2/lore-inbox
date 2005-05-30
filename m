Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVE3J6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVE3J6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVE3J6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:58:43 -0400
Received: from gate.corvil.net ([213.94.219.177]:261 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261594AbVE3Jzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:55:31 -0400
Message-ID: <429AE305.30502@draigBrady.com>
Date: Mon, 30 May 2005 10:55:17 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Liangchen Zheng <zlc@dream.eng.uci.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: The values of gettimeofday() jumps.
References: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
In-Reply-To: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liangchen Zheng wrote:
> Hello,
> 	We have several SMP machines (Tyan Tiger MPX motherboard, 2
> AthlonMP 1900+ CPU, linux-2.4.21-20.EL).  When running some time
> sensitive programs, I observed that the values of gettimeofday() jumped
> sometimes on a couple of machines (other machines are fine), from
> several hundreds milliseconds to a couple of seconds.

That sounds like what I described here:
http://lkml.org/lkml/2005/4/4/57

2 options as far as I can see.

1. Use irq affinity to bind the timer irq to a particular CPU,
    while using CPU affinity to bind your process to a particular CPU.

2. Change the code to maintain a last_tsc_low for each CPU.

-- 
Pádraig Brady - http://www.pixelbeat.org
--

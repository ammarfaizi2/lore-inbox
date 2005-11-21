Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVKUIJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVKUIJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVKUIJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:09:46 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:23946 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932215AbVKUIJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:09:46 -0500
Message-ID: <438180C0.2030503@comhem.se>
Date: Mon, 21 Nov 2005 09:09:36 +0100
From: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: 7eggert@gmx.de, nish.aravamudan@gmail.com
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
References: <5aZsv-3CJ-17@gated-at.bofh.it> <E1EdwGs-0000qv-NL@be1.lrz>
In-Reply-To: <E1EdwGs-0000qv-NL@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bodo Eggert wrote:
> Daniel Marjamäki <daniel.marjamaki@comhem.se> wrote:
> 
> 
>>-     aztTimeOutCount = 0;
>>+     aztTimeOut = jiffies + 2;
> 
> 
> Different timeout based on HZ seems wrong.

Yes, but..

If I'd say "HZ/100", then all systems that uses my driver must have HZ>=200.

The way I do it:
All systems will give me a delay for at least a few ms.
I get the shortest timeout possible on each computer.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUEVCgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUEVCgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUEVCck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:32:40 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:38067 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265174AbUEUWh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:37:27 -0400
Message-ID: <40AE837E.4030708@linuxmail.org>
Date: Sat, 22 May 2004 08:32:30 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org> <200405211542.40587.oliver@neukum.org>
In-Reply-To: <200405211542.40587.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Oliver Neukum wrote:
> Am Freitag, 21. Mai 2004 14:28 schrieb Nigel Cunningham:
>>Yes, but what order? I played with that problem for ages. Perhaps I just 
>>  didn't find the right combination.
> How about recording the order of creation and do it in opposite order?

We could add a field to the process struct to record that. (Since PIDs 
can wrap, they can't be relied upon for this).

One potential problem is that we'd race with processes that were 
forking, but that's a problem with the existing implementation anyway.

I can see that the only way I'm going to convince people that we need 
the method I settled on is by showing the deficiencies of the current one :<

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.

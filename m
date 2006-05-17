Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWEQMQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWEQMQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWEQMQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:16:39 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:45584 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751257AbWEQMQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:16:38 -0400
Message-ID: <446B141B.7050506@argo.co.il>
Date: Wed, 17 May 2006 15:16:27 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Joerg Pommnitz <pommnitz@yahoo.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wiretapping Linux?
References: <20060517120205.68976.qmail@web51406.mail.yahoo.com>
In-Reply-To: <20060517120205.68976.qmail@web51406.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2006 12:16:34.0977 (UTC) FILETIME=[BD599110:01C679AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Pommnitz wrote:
> Additionally its listening on the system bus. Question: Can it tap into 
> data addressed to another peripheral (say the hd controller)? If so, then 
> only the system RAM is outside its scope.
>   

A pci device can read system RAM and other memory-mapped PCI devices 
(such as display framebuffers) using DMA. In addition, a pci (but not 
pci-express) device can snoop on pci bus traffic to other devices. 
Typically, however, hard drive controllers will be integrated into the 
chipset so the data is not on the bus.

-- 
error compiling committee.c: too many arguments to function


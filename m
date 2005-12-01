Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVLAM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVLAM1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVLAM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:27:47 -0500
Received: from [82.94.235.172] ([82.94.235.172]:35510 "EHLO
	mail.hipersonik.com") by vger.kernel.org with ESMTP id S932187AbVLAM1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:27:46 -0500
From: Norbert van Nobelen <norbert-kernel@hipersonik.com>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: loadavg always equal or above 1.00 - how to explain?
Date: Thu, 1 Dec 2005 13:30:32 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <438EE515.1080001@wpkg.org>
In-Reply-To: <438EE515.1080001@wpkg.org>
Organization: Hipersonik.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512011330.32435.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you use top to determine which process is requesting most of the CPU? 


On Thursday 01 December 2005 12:57, Tomasz Chmielewski wrote:
> I noticed one of my Samba + OpenLDAP servers, running 2.6.11.4 kernel
> has loadavg always equal or above 1.00, although I can't explain it.
>
> # cat /proc/loadavg
> 1.00 1.10 1.06 1/65 782
>
> This server is barely used, and as I remember, loadavg was always close
> to 0.00 on that system.
>
> When I view the process list with top, no process takes more than 1% of
> CPU time; RAM usage is also minimal:
>
>
> # free
>               total       used       free     shared    buffers     cached
> Mem:        320836     241016      79820          0      23308     177232
> -/+ buffers/cache:      40476     280360
> Swap:       811272      14612     796660
>
> This has ~ 50 processes running (ps aux|wc -l), and ~ 50 network
> connections (netstat -tupna|wc -l), so everything normal.
>
> Nothing unusual in dmesg, too.
>
> What can cause this anormal load, and how can I spot it?

-- 
________
www.hipersonik.com : Open source experts

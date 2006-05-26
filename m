Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWEZE46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWEZE46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWEZE46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:56:58 -0400
Received: from relay4.usu.ru ([194.226.235.39]:54159 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1030393AbWEZE45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:56:57 -0400
Message-ID: <44768AAD.3030800@ums.usu.ru>
Date: Fri, 26 May 2006 10:57:17 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matheus Izvekov <mizvekov@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>	 <44747432.1090906@ums.usu.ru>	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>	 <4474891D.9010205@ums.usu.ru> <9e4733910605240932s61bb124fre3ec217d69956e78@mail.gmail.com>
In-Reply-To: <9e4733910605240932s61bb124fre3ec217d69956e78@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.32; VDF: 6.34.1.143; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Most video hardware (99%) has enough memory to support double
> buffering. You save it to the other buffer, display the error, and
> copy it back on enter.

This is possible only if the video memory management is in the kernel. Reason: 
userspace may also want to use double buffering, and we definitely want to 
allocate the "other (maybe third) buffer" somewhere in the free video memory. 
And allocating a lot of system RAM on oops seems to be a very bad idea (cascade 
of oopses may follow).

Also, did anyone measure the video RAM usage during a typical Xgl session (i.e.: 
is there really enough free video RAM, not occupied by various caches)?

Although, a Microsoft-ish "lost context, please redraw" solution has been 
already proposed.

-- 
Alexander E. Patrakov

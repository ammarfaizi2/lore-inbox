Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTJGN3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTJGN3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:29:43 -0400
Received: from main.gmane.org ([80.91.224.249]:36578 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262181AbTJGN3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:29:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet@andreas-s.net>
Subject: Re: Extremely low disk performance on K7S5A Pro
Date: Tue, 7 Oct 2003 13:29:40 +0000 (UTC)
Message-ID: <slrnbo5fuo.l0e.usenet@home.andreas-s.net>
References: <slrnbnoi5i.3re.usenet@home.andreas-s.net> <3F813E19.7020303@inet6.fr>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:
> Andreas Schwarz said the following on 10/02/2003 05:47 PM:
>
>>Hi,
>>
>>since I replaced my Abit KT7 with an Elitegroup K7S5A Pro (SIS735), I've
>>got extremly low disk performance with every tested kernel version
>>(2.4.20, 2.6.0-test6-mm2):
>>
>># hdparm -tT /dev/hda                                                           
>>/dev/hda:                                                                       
>> Timing buffer-cache reads:   824 MB in  2.00 seconds = 411.65 MB/sec           
>> Timing buffered disk reads:   10 MB in  3.28 seconds =   3.05 MB/sec
>>                                                          ^^^^
>>
>>DMA, 32bit etc. is activated (hdparm -d1 -c3 -u1 /dev/hda):
>>
>>  
>>
>
> 3.05 MB is even less than what I'm used to see with most drives and *PIO 
> 4* !

I found the source of the problem: I was using athcool to enable the "bus
disconnect when STPGNT detected" bit on startup. That didn't cause any
problems with my old board (Abit KT7), but the K7S5A seems to be
allergic to it. Sorry if I wasted your time!

Andreas


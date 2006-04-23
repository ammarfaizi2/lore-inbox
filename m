Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWDWJXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWDWJXX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWDWJXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:23:23 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:26636 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750987AbWDWJXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:23:22 -0400
Message-ID: <444B4784.8040803@argo.co.il>
Date: Sun, 23 Apr 2006 12:23:16 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604211852.47335.netdev@axxeo.de> <20060422114846.GA6629@wohnheim.fh-wedel.de> <200604221529.59899.ioe-lkml@rameria.de>
In-Reply-To: <200604221529.59899.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Apr 2006 09:23:18.0711 (UTC) FILETIME=[8EC74470:01C666B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Jörn,
>
> On Saturday, 22. April 2006 13:48, Jörn Engel wrote:
>   
>> Unless I completely misunderstand something, one of the main points of
>> the netchannels if to have *zero* fields written to by both producer
>> and consumer. 
>>     
>
> Hmm, for me the main point was to keep the complete processing
> of a single packet within one CPU/Core where this is a non-issue.
>   
But the interrupt for a packet can be received by cpu 0 whereas the rest 
of processing proceeds on cpu 1; so it still helps to keep the producer 
index and consumer index on separate cachelines.

-- 
error compiling committee.c: too many arguments to function


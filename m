Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271827AbTG2OMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTG2OMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:12:42 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:8721 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271827AbTG2OK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:10:58 -0400
Message-ID: <3F2682EF.2040702@techsource.com>
Date: Tue, 29 Jul 2003 10:21:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

> I'm guessing that the anticipatory scheduler is the culprit here.  Soon as I figure
> out the incantations to use the deadline scheduler, I'll report back....
> 

It would be unfortunate if AS and the interactivity scheduler were to 
conflict.  Is there a way we can have them talk to each other and have 
AS boost some I/O requests for tasks which are marked as interactive?

It would sacrifice some throughput for the sake of interactivity, which 
is what the interactivity patches do anyhow.  This is a reasonable 
compromise.


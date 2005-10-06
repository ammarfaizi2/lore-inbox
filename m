Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVJFP06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVJFP06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJFP05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:26:57 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:17327 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751091AbVJFP05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:26:57 -0400
Message-ID: <43454238.4040907@nortel.com>
Date: Thu, 06 Oct 2005 09:26:48 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Riesen <raa.lkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
References: <1128606546.14385.26.camel@penguin.madhu> <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
In-Reply-To: <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 15:26:51.0082 (UTC) FILETIME=[5FC2B2A0:01C5CA8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:

> Why don't you just use nanosleep(2) (or usleep)?

I can think of one main reason...existing code.  Also, nanosleep() 
rounds up excessively in many kernel versions, so that a request to 
sleep for less than 1 tick ends up sleeping for 2 ticks.

The select() man page explicitly mentions this usage;

"Some code calls select with all three sets empty, n zero, and a 
non-null timeout as a fairly portable way to sleep with subsecond 
precision."

Chris


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWFJA15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWFJA15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWFJA15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:27:57 -0400
Received: from palrel10.hp.com ([156.153.255.245]:22990 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932611AbWFJA14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:27:56 -0400
Message-ID: <448A1208.3060602@hp.com>
Date: Fri, 09 Jun 2006 17:27:52 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 5/6] [Network namespace] ipv4 isolation
References: <20060609210202.215291000@localhost.localdomain>	<20060609210631.346330000@localhost.localdomain> <Pine.LNX.4.64.0606092022320.17380@d.namei>
In-Reply-To: <Pine.LNX.4.64.0606092022320.17380@d.namei>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Fri, 9 Jun 2006, dlezcano@fr.ibm.com wrote:
> 
> 
>>When an outgoing packet has the loopback destination addres, the
>>skbuff is filled with the network namespace. So the loopback packets
>>never go outside the namespace. This approach facilitate the migration
>>of loopback because identification is done by network namespace and
>>not by address. The loopback has been benchmarked by tbench and the
>>overhead is roughly 1.5 %
> 
> 
> I think you'll need to make it so this code has zero impact when not 
> configured.

Indeed, and over stuff other than loopback too.  I'll not so humbly 
suggest :)  netperf TCP_STREAM and TCP_RR figures _with_ CPU 
utilization/service demand measures.

rick jones

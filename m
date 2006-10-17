Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWJQSXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWJQSXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWJQSXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:23:12 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:48075 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751378AbWJQSXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:23:11 -0400
Message-ID: <45351EC6.7080307@cfl.rr.com>
Date: Tue, 17 Oct 2006 14:19:50 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: mauelshagen@redhat.com
CC: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dm stripe: Fix bounds
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <20061017085022.GB4800@redhat.com>
In-Reply-To: <20061017085022.GB4800@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2006 18:19:51.0301 (UTC) FILETIME=[D62C6B50:01C6F218]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14756.003
X-TM-AS-Result: No--13.819500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out my raid volume's size according to the metadata on disk IS an 
even multiple of the stripe factor, so it looks like this is a bug in 
dmraid, and I have taken the issue to the ataraid mailing list.

Heinz Mauelshagen wrote:
> On Thu, Oct 12, 2006 at 02:59:45PM +0100, Alasdair G Kergon wrote:
>> On Thu, Oct 12, 2006 at 12:01:21AM -0400, Phillip Susi wrote:
>>> now dmraid fails to configure the dm 
>>> table because this patch rejects it.
>>  
>>> I believe the correct thing to do is to special case the last stripe in 
>>> 0-31    64-67
>>> 32-63   68-71
>>  
>> AFAIK current versions of dmraid handle this correctly - Heinz?
> 
> Yes, that's correct.
> 
>> Alasdair
>> -- 
>> agk@redhat.com
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVEFSSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVEFSSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEFSSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:18:06 -0400
Received: from fmr18.intel.com ([134.134.136.17]:17824 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261259AbVEFSR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:17:59 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Fri, 6 May 2005 11:13:26 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcVSK5eKRtUKzrMuSX21p+1C//h61wAOyViw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>,
       "Daniel Walker" <dwalker@mvista.com>, "Ingo Molnar" <mingo@elte.hu>
X-OriginalArrivalTime: 06 May 2005 18:13:28.0698 (UTC) FILETIME=[4D9A15A0:01C55267]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: tmp@several.ru [mailto:tmp@several.ru] On Behalf Of Oleg Nesterov
>Sent: Friday, May 06, 2005 4:13 AM
>To: linux-kernel@vger.kernel.org; Daniel Walker; Perez-Gonzalez, Inaky;
Ingo Molnar
>Subject: Re: [PATCH] Priority Lists for the RT mutex
>
>Oleg Nesterov wrote:
>>
>> Daniel Walker wrote:
>> >
>> > Description:
>> > 	This patch adds the priority list data structure from Inaky
Perez-Gonzalez
>> > to the Preempt Real-Time mutex.
>> >
>> ...
>>
>> I can't understand how this can work.
>
>And I think it is possible to simplify plist's design.
>
> ...
>
>					 struct plist, prio_list);
>			goto eq_prio;
>		}
>
>lt_prio:
>	list_add_tail(&new->prio_list, &pos->prio_list);
>eq_prio:
>	list_add_tail(&new->node_list, &pos->node_list);
>}

Isn't this adding them to *both* lists in the lt_prio
case? I don't understand what do you want to accomplish
in this case.

[like for example, if the list is empty and you add one,
it will start a new node_list, but you have also added
it to the head's prio_list] 

If you ware changing the operational mode, can you please
explain your change in more detail?

It could also be I have *the* headache...but hey :)

-- Inaky 

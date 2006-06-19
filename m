Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWFSN2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWFSN2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFSN2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:28:30 -0400
Received: from mailgw4.ericsson.se ([193.180.251.62]:37037 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP id S932411AbWFSN2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:28:30 -0400
Message-ID: <4496A677.3020301@ericsson.com>
Date: Mon, 19 Jun 2006 15:28:23 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com> <m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 13:28:28.0417 (UTC) FILETIME=[3FFE0710:01C693A4]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> writes:
>
>  
>
>>On Fri, 16 Jun 2006 10:37:05 -0600
>>ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>>    
>>
>>>>The processing of the notifier is to make a SCSI adaptor power off to
>>>>stop writing in the shared disk completely and then notify to standby-node.
>>>>        
>>>>
>>>The kernel has called panic no new SCSI operations were execute.
>>>I'm not saying don't notify your standby-node
>>>      
>>>
>>As you say, the kernel does not do anything about SCSI operations.
>>But many SCSI adaptors flush their cache after a few seconds pass
>>after a SCSI write command is invoked, especially RAID cards.
>>To completely stop writing immediately, we should make the adaptor
>>power off.
>>    
>>
>
>Yes.  Although I don't have a clue what big scsi has to do with a
>telco systems.
>  
>
Strictly speaking for myself: Nothing.

Mr. Akiyama Nobuyuk gave an example from his environment which is cluster systems.
I was the one saying we in our Telco systems could use this feature too.

The only thing Mr. Akiyama Nobuyuk and I have in common is we both would like to do
something before crash dumping, simply because the less mess we will have to cleanup
afterwards in the system taking over, the better.

Mr. Akiyama Nobuyuk operates on SCSI devices to avoid filesystem corruptions.
My usage would be more like notifying external management to get traffic 
redirected to server systems taking over.

./Preben




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbVKPXig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVKPXig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKPXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:38:36 -0500
Received: from mexforward.lss.emc.com ([168.159.2.8]:30049 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1161017AbVKPXig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:38:36 -0500
Message-ID: <437BC2D7.3080003@emc.com>
Date: Wed, 16 Nov 2005 18:37:59 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, hugh@veritas.com, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] sys_punchhole()
References: <1131664994.25354.36.camel@localhost.localdomain>	 <20051110153254.5dde61c5.akpm@osdl.org>	 <20051113150906.GA2193@spitz.ucw.cz> <1132178470.24066.85.camel@localhost.localdomain>
In-Reply-To: <1132178470.24066.85.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.11.16.29
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

>On Sun, 2005-11-13 at 15:09 +0000, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>    
>>
>>>>We discussed this in madvise(REMOVE) thread - to add support 
>>>>for sys_punchhole(fd, offset, len) to complete the functionality
>>>>(in the future).
>>>>
>>>>http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
>>>>
>>>>What I am wondering is, should I invest time now to do it ?
>>>>        
>>>>
>>>I haven't even heard anyone mention a need for this in the past 1-2 years.
>>>      
>>>
>>Some database people wanted it maybe month ago. It was replaced by some 
>>madvise hack...
>>    
>>
>
>Hmm. Someone other than me asking for it ? 
>
>I did the madvise() hack and asking to see if any one really needs
>sys_punchole().
>
>Thanks,
>Badari
>
>
>  
>
I think that sys_punchole() would be useful for some object based 
storage systems.

Specifically, when you have a box that is trying to store potentially a 
billion objects on one file system, pushing several objects into a file 
("container") can be useful to keep the object count down.  The punch 
hole would be useful in reclaiming space in this type of scheme.

On the other side of the argument, you can argue that file systems that 
support large file counts and really big directories should perform well 
enough to make this use case less important.

ric



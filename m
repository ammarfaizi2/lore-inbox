Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTE2KXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTE2KXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:23:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:63907 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262116AbTE2KXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:23:34 -0400
Message-ID: <3ED5E29F.3010900@colorfullife.com>
Date: Thu, 29 May 2003 12:36:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arvind Kandhare <arvind.kan@wipro.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
       Dave Jones <davej@suse.de>, roystgnr@owlnet.rice.edu,
       garagan@borg.cs.dal.ca
Subject: Re: Changing SEMVMX to a tunable parameter
References: <3ED4C6B6.7050806@wipro.com> <3ED4E0BB.2080603@colorfullife.com> <3ED5DE49.5CA79049@wipro.com>
In-Reply-To: <3ED5DE49.5CA79049@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Kandhare wrote:

>1. Most of the IPC parameters (e.g. msgmni, msgmax, 
>msgmnb , shmmni, shmmax) are tunables. 
>
>(Please refer : 
>http://web.gnu.walfield.org/mail-archive/linux-kernel-digest/1999-November/0020.html)
>
>Was there any specific reason why semvmx was not made a tunable with the 
>above set??  
>  
>
Because I didn't see the need for making it tunable.

>2. By having semvmx as tunable, administrator gets more flexibility 
>in controlling the resource usage on the system:
>        a. By increasing this, it is possible to allow more     
>        processes to use the system resources controlled by a
>        semaphore concurrently.
>  
>
Changing semvmx has no effect on the resource usage: An integer occupies 
4 bytes, a short 2 bytes, independant of it's value.

>Because of problems with dynamic tuning (ref first mail on the subject), 
>static tuning (boot time) is proposed.
>
>Please let us know your comments.
>  
>
Review everything for signed/unsigned problems, then post your findings 
and a patch that increases the limit to 64k. The whole patch will be 
shorter than the "confidential" disclaimer at the end of your mails.

--
    Manfred


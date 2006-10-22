Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWJVRmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWJVRmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWJVRmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:42:07 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:12083 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751761AbWJVRmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:42:04 -0400
Message-ID: <453BAD66.5000406@qumranet.com>
Date: Sun, 22 Oct 2006 19:41:58 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com> <200610221906.33085.arnd@arndb.de>
In-Reply-To: <200610221906.33085.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 17:42:03.0925 (UTC) FILETIME=[62C70C50:01C6F601]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sunday 22 October 2006 19:01, Avi Kivity wrote:
>   
>>> While we don't have it yet, we're thinking about adding a sputop
>>> or something similar that shows the utilization of spus. You don't
>>> need that one, since get exactly that with the regular top, but you
>>> might want to have a tool that prints statistics about how often
>>> your guests drop out of the virtualisation mode, or the number
>>> of interrupts delivered to them.
>>>
>>>  
>>>       
>> We have a debugfs interface and a kvm_stat script which shows exactly
>> that (including a breakdown of the reasons for the exit).
>>     
>
> Ok, good. But with your own file system, you wouldn't need debugfs
> any more and have all information about a guest in one place.
>   

One last thing: permissions.  The /dev/kvm model allows permissions to 
be controlled using standard unix access methods.  How do you control 
access to spufs?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


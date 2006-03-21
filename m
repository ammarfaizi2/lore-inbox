Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWCUKn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWCUKn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCUKn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:43:58 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:28048 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932412AbWCUKn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:43:57 -0500
Message-ID: <441FD8F3.208@us.ibm.com>
Date: Tue, 21 Mar 2006 05:44:03 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes to	sysfs
References: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com> <1142925269.3077.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1142925269.3077.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>> +---properties
>> |   >---capabilities
>> |   >---changeset
> 
> how is this a property and not part of version?
Agree, changeset should be part of version

> again what is the justification of putting this in the kernel? I though
> everyone here was agreed that since the management tools that need this
> talk to the hypervisor ANYWAY, they might as well just ask this
> information as well....

I think we had a good discussion but short of agreement. Some tools want to 
read a file from /sys/hypervisor/ rather than call a c lib. (In other words, 
not all tools will talk to the hypervisor.) It is appropriate to view the 
hypervisor as a hardware device so it is appropriate to have some information 
in sysfs. 

I appreciate the counter argument as well, but think this should be a 
configurable option. 

thanks, 

Mike

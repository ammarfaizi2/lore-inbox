Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWHWJBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWHWJBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWHWJBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:01:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:57293 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751462AbWHWJBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:01:03 -0400
Message-ID: <44EC194E.6080606@vmware.com>
Date: Wed, 23 Aug 2006 02:01:02 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <1156319788.2829.12.camel@laptopd505.fenrus.org> <44EC1563.90206@vmware.com> <200608231050.13272.ak@suse.de>
In-Reply-To: <200608231050.13272.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Yes, after discussion with Rusty, it appears that beefing up 
>> stop_machine_run is the right way to go.  And it has benefits for 
>> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
>> extension modules to be loaded without having to deal with a debug 
>> exception or NMI during module load/unload.
>>     
>
> I'm still unclear where you think those debug exceptions will come from

kprobes set in the stop_machine code - which is probably a really bad 
idea, but nothing today actively stops kprobes from doing that.

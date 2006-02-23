Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWBWXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWBWXxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWBWXxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:53:07 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:14214 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932141AbWBWXxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:53:05 -0500
Message-ID: <43FE4B00.8080205@keyaccess.nl>
Date: Fri, 24 Feb 2006 00:53:36 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org> <43FE1764.6000300@keyaccess.nl> <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, 23 Feb 2006, Rene Herman wrote:

>> Okay. I suppose the only other option is to make "physical_start" a variable
>> passed in by the bootloader so that it could make a runtime decision? Ie,
>> place us at min(top_of_mem, 4G) if it cared to. I just grepped for
>> PHYSICAL_START and this didn't look _too_ bad.
> 
> No can do. You'd have to make the kernel relocatable, and do load-time 
> fixups. Very invasive.

Yes, that wasn't too smart. I believe in principe most of it _could_ be 
done via some pagetable trickery though, with the kernel still at a 
fixed virtual address?

Rene.

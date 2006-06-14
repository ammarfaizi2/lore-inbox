Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWFNOks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFNOks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWFNOks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:40:48 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:53264 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S964987AbWFNOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:40:48 -0400
Message-ID: <44901FC2.7040600@superbug.co.uk>
Date: Wed, 14 Jun 2006 15:40:02 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Jason <bofh1234567@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEPORT and multicasting
References: <20060613192420.49742.qmail@web53603.mail.yahoo.com>
In-Reply-To: <20060613192420.49742.qmail@web53603.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason wrote:
> I wrote a program that uses multicasting to send data.
>  It works great on HP-UX but does not work on Fedora
> Core 5.  I emailed the fedora list but they were of
> little to no help.  
>
> Does the kernel support SO_REUSEPORT?  If so can
> anyone give me some suggestions why my program does
> not work on Linux?  I did a route add -net 224.0.0.0/4
> dev eth0 but that did not do anything.
>
> Thanks,
> Jesse
>
>   
That address is a multicast address, and therefore needs to go in the 
multicast routing table, and not the unicast one.
You are using a command that only modifies the unicast table.

James


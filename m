Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVA0COS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVA0COS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVAZXqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:46:17 -0500
Received: from alog0267.analogic.com ([208.224.222.43]:43392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261981AbVAZTK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:10:26 -0500
Date: Wed, 26 Jan 2005 14:09:40 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Rik van Riel <riel@redhat.com>
cc: Bryn Reeves <breeves@redhat.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       James Antill <james.antill@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501261353260.5677@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0501261407120.18468@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> 
 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com> 
 <41F7D4B0.7070401@nortelnetworks.com> <1106762261.10384.30.camel@breeves.surrey.redhat.com>
 <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
 <Pine.LNX.4.61.0501261353260.5677@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Rik van Riel wrote:

> On Wed, 26 Jan 2005, linux-os wrote:
>
>> Wrong! A returned value of 0 is perfectly correct for mmap()
>> when mapping a fixed address. The attached code shows it working
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The code that is patched is only run in case of a non-MAP_FIXED
> mmap() call...
>

That's good then. I needed to make sure. Lots of embedded stuff
peeks and pokes at ix86 low-memory physical addresses.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

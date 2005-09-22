Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVIVGuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVIVGuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVIVGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:50:40 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:43428 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932140AbVIVGuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:50:40 -0400
Message-ID: <4332548E.9050602@aitel.hist.no>
Date: Thu, 22 Sep 2005 08:51:58 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: rep stsb <repstsb@yahoo.ca>, linux-kernel@vger.kernel.org,
       06020051@lums.edu.pk
Subject: Re: In-kernel graphics subsystem
References: <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com> <200509220606.j8M66u8d010990@turing-police.cc.vt.edu>
In-Reply-To: <200509220606.j8M66u8d010990@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Thu, 22 Sep 2005 01:51:20 EDT, rep stsb said:
>
>  
>
>>1. Convert svgalib drivers into kernel modules to get
>>v-sync interrupts. 
>>
>>2. Write a windowing program on svgalib. 
>>    
>>
>
>Wouldn't it make more sense to extend the current framebuffer driver
>support to support v-sync? (framebuffers are already in the kernel, and
>there were so many security holes with svgalib-based programs that it left
>a bad taste in a lot of people's mouths)
>
>And having gotten a v-sync interrupt, what would you *do* with it?
>You'll need an API here....
>  
>
Simple.  What we want from such interrupts, is to wait for them, no?
So lets use one of the existing structures made for waiting.  One example
is a file descriptor.  Do a blocking read, which the kernel unblocks when
the interrupt comes in. A file descriptor also supports things like
select() if need be.

Helge Hafting

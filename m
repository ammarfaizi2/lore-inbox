Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSKHNvQ>; Fri, 8 Nov 2002 08:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSKHNvQ>; Fri, 8 Nov 2002 08:51:16 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:24328 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S262020AbSKHNvO>; Fri, 8 Nov 2002 08:51:14 -0500
Message-ID: <3DCBC2E3.5040503@convergence.de>
Date: Fri, 08 Nov 2002 14:57:55 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Switch DVB to generic crc32.
References: <28280.1036753951@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> Not entirely sure why the DVB core code has its own crc32 table -- not only 
> should it be using the one the kernel provides, but AFAICT nothing in the 
> tree actually seem to _use_ its dvb_set_crc32() function anyway.

the crc32 table was defined because the same driver works for 2.4 
kernels, there we need our own crc32 implementation. I'll check if we 
can use the generic code in the kernel and then move the dvb_crc32 code 
into the 2.4 compatibility file compat.c

That the crc32 check is currently not called by the software 
demultiplexer is a known bug, it's already fixed in local CVS and will 
get into the kernel with the next patchset. I'm currently preparing this 
patchset but want to test it a little more.

Alan: do you have doubts or is there a reason not to apply the last 
patchset I sent you on Tue, 29 Oct 2002? (well - it was kind of huge, 
but all the namespace fixes and cleanups should justify the patch's 
size, not?)

Holger


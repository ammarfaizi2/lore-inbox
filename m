Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTB0Rsw>; Thu, 27 Feb 2003 12:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbTB0Rsw>; Thu, 27 Feb 2003 12:48:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:61945 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265736AbTB0Rsu>; Thu, 27 Feb 2003 12:48:50 -0500
Message-ID: <3E5E50C4.1070906@us.ibm.com>
Date: Thu, 27 Feb 2003 09:54:12 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: oprofile-list@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops running oprofile in 2.5.62
References: <3E5DB057.60503@us.ibm.com> <20030227173704.GA76419@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> On Wed, Feb 26, 2003 at 10:29:43PM -0800, Dave Hansen wrote:
> 
>>I'm pretty sure it happened on this line in oprofile_add_sample():
>>	cpu_buf->buffer[cpu_buf->pos].eip = eip;
>>
>>Unable to handle kernel paging request at virtual address f8c3c000
> 
> Odd. UP or SMP ? Were you shutting down oprofile at the time (or did the
> daemon crash ? check /var/lib/oprofile/oprofiled.log)

16-way NUMAQ :)  It was in the middle of a dbench run, so nothing
critical was happening with oprofile.

> The only thing I can think is that the buffer got freed then we  got an
> NMI afterwards (which obviously isn't supposed to happen...)

The irqbalance code is causing some funniness on these machines, so it
might be related.  I'll speak up if I see it again.

-- 
Dave Hansen
haveblue@us.ibm.com


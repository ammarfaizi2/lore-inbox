Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264549AbUDZLtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUDZLtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 07:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUDZLtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 07:49:50 -0400
Received: from mail.tpgi.com.au ([203.12.160.100]:26313 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264549AbUDZLts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 07:49:48 -0400
Date: Mon, 26 Apr 2004 21:27:13 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Roland Stigge" <stigge@antcom.de>, 234976@bugs.debian.org
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: "Pavel Machek" <pavel@suse.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <E1B6on4-0005EW-00@gondolin.me.apana.org.au> <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <20040426104015.GA5772@gondor.apana.org.au>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 26 Apr 2004 20:40:15 +1000, Herbert Xu  
<herbert@gondor.apana.org.au> wrote:

> On Mon, Apr 26, 2004 at 07:48:34PM +1000, herbert wrote:
>>
>> A simple solution is to copy the pages in reverse.  This way the
>> top page table is filled in last which should resolve this particular
>> issue.  The following patch does exactly that and fixes the problem
>> for me.
>
> Of course this doesn't work for machines without PSE.  But then the
> original code didn't work either.  Since resuming from 486's isn't
> that cool anyway, IMHO someone should just add a PSE check in the
> swsusp/pmdisk init code on i386.

There used to be such a check. Centrinos, however, if I recall correctly,  
don't have PSE but can suspend with our current method. Perhaps we can  
come up with a more nuanced test? Better still, though, we should just get  
proper AGP support for suspending and resuming in.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)

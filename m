Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSE3XWT>; Thu, 30 May 2002 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSE3XWS>; Thu, 30 May 2002 19:22:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26129 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316928AbSE3XWQ>;
	Thu, 30 May 2002 19:22:16 -0400
Message-ID: <3CF6B3AD.6010106@mandrakesoft.com>
Date: Thu, 30 May 2002 19:20:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 cpu selection (first hack)
In-Reply-To: <20020530225015.GA1829@werewolf.able.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>- Make all and every cpu a checkbox, so you just say 'I want my kernel to
>  support this and that CPU'. This kills the problem of the ordering, and
>  adds one other advantage: you do not need to support intermediate CPUs,
>  like 'i want my kernel to run ok on pentium-mmx (my firewall) and on
>  p4 (my desktop). I will never run it on a PII, so do not include the
>  hacks for PII'. And of course, 'If I run my p-mmx capable on a friend's
>  PII and it eats his drive and burns his TV set, it is only _my_ fault'.
>
>Patch follows, comments are welcome. Next step is to begin to order the logic,
>but I wanted to ask first about this.
>  
>


First cut seems like a good start...

Comments:
* use standard CML indentation
* use CONFIG_X86_ as the prefix for all config symbols you're creating
* Alan's comment seems fair, and also gives me a tangential idea: I 
wonder if making the CPU features selectable is useful? i.e. provide an 
actual config option for MMX memcpy, F00F bug, WP, etc. Normal (current) 
logic is to look at the cpu selected, and deduce these options.

Jeff





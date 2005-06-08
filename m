Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFHOnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFHOnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVFHOnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:43:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:11141 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261270AbVFHOnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:43:03 -0400
Message-ID: <42A7039E.7030109@grupopie.com>
Date: Wed, 08 Jun 2005 15:41:34 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A6FE52.1050705@stud.feec.vutbr.cz>
In-Reply-To: <42A6FE52.1050705@stud.feec.vutbr.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> [...]
> The build fails with inconsistent kallsyms data:
>[...]
>   SYSMAP  .tmp_System.map
> Inconsistent kallsyms data
> Try setting CONFIG_KALLSYMS_EXTRA_PASS
> make: *** [vmlinux] Error 1
> 
> When I enable the workaround CONFIG_KALLSYMS_EXTRA_PASS, it works.
> This is on i386, Debian Sarge. I'm attaching my .config.

This is probably just bad luck and a known problem that I'm trying to 
fix (but hadn't have much time lately).

Can you try to change the line:

#define WORKING_SET		1024

in scripts/kallsyms.c to:

#define WORKING_SET		65536

and disable CONFIG_KALLSYMS_EXTRA_PASS, to see if the problem goes away?

It it does go away, then it is the same problem, and I'm working on it...

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)

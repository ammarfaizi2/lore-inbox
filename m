Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVBBLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVBBLzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 06:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVBBLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 06:55:36 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60647 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262448AbVBBLzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 06:55:25 -0500
Message-ID: <4200BFA1.2060808@grupopie.com>
Date: Wed, 02 Feb 2005 11:55:13 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, penberg@cs.helsinki.fi
Subject: Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
References: <1107228511.41fef75f4a296@webmail.grupopie.com> <84144f02050201235257d0ec1c@mail.gmail.com>
In-Reply-To: <84144f02050201235257d0ec1c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On Tue,  1 Feb 2005 03:28:31 +0000, pmarques@grupopie.com
> <pmarques@grupopie.com> wrote:
> 
>>diff -buprN -X dontdiff vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c
>>--- vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c       2004-12-24 21:35:40.000000000 +0000
>>+++ linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c 2005-01-31 20:39:08.591154025 +0000
> 
> 
> [snip]
> 
> 
>>-               pri->dev_name = uml_strdup(buffer);
>>+               pri->dev_name = kstrdup(buffer);
> 
> 
> Please compile-test before submitting.

I'm really sorry about this...

I've compiled with an allyesconfig to validate the changes, but that 
doesn't build the UML parts :(

Anyway, thanks for pointing this out. I still haven't got feedback 
regarding the acceptance of these patches. If there is a chance they're 
accepted, maybe the best thing to do is to post the series again with 
this correction and the sound patch corrections.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

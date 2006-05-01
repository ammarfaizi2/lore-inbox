Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWEASvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWEASvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWEASvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:51:04 -0400
Received: from uproxy.gmail.com ([66.249.92.172]:8492 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932191AbWEASvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:51:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rYxVwLKWvlk/d/isdIWA7aC9cCg55mKekfK5QdxUFnpWBnyVjcxgNHnPy2Wk7VSSqm6OkJdyryPTDpEHMcLhuUcOV5GX2bo0bMvm+QHJbFKnY9pDinc6NXEsXdYYeNMF3rifye+nTeXoRKvHnNrO3dCIyoM21wTugOnhf+d5vcw=
Message-ID: <44565861.3000907@gmail.com>
Date: Mon, 01 May 2006 20:50:09 +0200
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
References: <44560796.8010700@gmail.com> <20060501100328.37527eb2.akpm@osdl.org> <4456430C.2040806@gmail.com> <44564B34.6020109@gmail.com>
In-Reply-To: <44564B34.6020109@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:

> Ok, which error?
> 
> regards,

Hi all,

Well, I have the error notice no longer at hand, but it was of the family of unreferenceable addresses. Do not forget that this fragment of code is related to functions included in bitops.h, and are 
architecture dependent and written in assembler.

By other hand, the dump core produced if kfree is employed, is already known and indexed through Google. So I am forced to set 'offset = NULL' in order to reassign the same old location to the next 
recurrence of kmalloc. So, things stay controlled.

What I can tell you for sure is that, employing this code, file after file writings and erasings of directories containing about 6.000 files to and from a Minix partition from Linux, filling and 
emptying spaces of 200 MB for testing, don't show any bad signal of memory leakage employing blocksizes of 4K which force the use of 'offset'.

Regards,

Daniel

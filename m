Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWDYG1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWDYG1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWDYG1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:27:14 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:46053 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932117AbWDYG1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:27:14 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
In-Reply-To: <OF346B0EC4.22389E6C-ON4225715A.00553273-4225715A.005EFC07@de.ibm.com>
References: <OF346B0EC4.22389E6C-ON4225715A.00553273-4225715A.005EFC07@de.ibm.com>
Date: Tue, 25 Apr 2006 09:27:10 +0300
Message-Id: <1145946431.11463.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:17 +0200, Michael Holzheu wrote:
> What about something like that:
> 
> /**
>  * strrtrim - Remove trailing characters specified in @reject
>  * @s: The string to be searched
>  * @reject: The string of letters to avoid
>  */
> static inline void strrtrim(char *s, const char *reject)

Better to make it out-of-line to save kernel text.

> {
>       char *p;
>       const char *r;
> 
>       for (p = s + strlen(s) - 1; s <= p; p--) {
>             for (r = reject; (*r != '\0') && (*p != *r); r++)
>                   /* nothing */;
>             if (*r == '\0')
>                   break;
>       }
>       *(p + 1) = '\0';
> }
> 
> Regards
> Michael
> 


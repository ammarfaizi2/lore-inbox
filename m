Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbSKPGZo>; Sat, 16 Nov 2002 01:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbSKPGZo>; Sat, 16 Nov 2002 01:25:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:38035 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267235AbSKPGZR>;
	Sat, 16 Nov 2002 01:25:17 -0500
Message-ID: <3DD5E65A.59243812@digeo.com>
Date: Fri, 15 Nov 2002 22:31:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
References: <87d6p63ui2.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2002 06:31:54.0545 (UTC) FILETIME=[DAED9210:01C28D39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> +char *strdup(const char *s)
> +{
> +       char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
> +       if (p)
> +               strcpy(p, s);
> +
> +       return p;
>  }

It's best to not assume GFP_KERNEL in there.  Make the caller
pass in the required allocation mode.

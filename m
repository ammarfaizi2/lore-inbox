Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSKPATn>; Fri, 15 Nov 2002 19:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbSKPATn>; Fri, 15 Nov 2002 19:19:43 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:20697 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266976AbSKPATm>; Fri, 15 Nov 2002 19:19:42 -0500
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20021115222725.1A56F2C0FA@lists.samba.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PARAM 1/4: strcspn
Date: Sat, 16 Nov 2002 01:25:55 +0100
In-Reply-To: <20021115222725.1A56F2C0FA@lists.samba.org> (Rusty Russell's
 message of "Sat, 16 Nov 2002 09:14:04 +1100")
Message-ID: <87k7jeicmk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> +size_t strcspn(const char *s, const char *reject)
> +{
> +	const char *p;
> +	const char *r;
> +	size_t count = 0;
> +
> +	for (p = s; *p != '\0'; ++p) {
> +		for (r = reject; *r != '\0'; ++r) {
> +			if (*p == *r)
> +				return count;
> +		}
> +		++count;
> +	}
> +
> +	return count;
> +}	

How about "return p - s;" instead of "count"?

Regards, Olaf.

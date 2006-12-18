Return-Path: <linux-kernel-owner+w=401wt.eu-S1752000AbWLRR4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWLRR4G (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWLRR4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:56:06 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:15486 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbWLRR4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:56:04 -0500
Date: Mon, 18 Dec 2006 09:57:04 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add a new section to CodingStyle, promoting
 include/linux/kernel.h.
Message-Id: <20061218095704.59687cc9.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
References: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 12:43:35 -0500 (EST) Robert P. J. Day wrote:

> 
>   Add a new section to the CodingStyle file, encouraging people not to
> re-invent available kernel macros such as ARRAY_SIZE(),
> FIELD_SIZEOF(), min() and max(), among others.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


> ---
> 
>   NOTE:  at the moment, there is not a single invocation of the
> FIELD_SIZEOF() macro anywhere in the entire source tree, so if someone
> had a hankering to rename it to something more catchy, now would be a
> good time and i can always resubmit the patch i sent in yesterday.
> 
> 
> 
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 0ad6dcb..a736333 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -682,6 +682,24 @@ result.  Typical examples would be functions that return pointers; they use
>  NULL or the ERR_PTR mechanism to report failure.
> 
> 
> +		Chapter 17:  Don't re-invent the kernel macros
> +
> +The header file include/linux/kernel.h contains a number of macros that
> +you should use, rather than explicitly coding some variant of them yourself.
> +For example, if you need to calculate the length of an array, take advantage
> +of the macro
> +
> +  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +Similarly, if you need to calculate the size of some structure member, use
> +
> +  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> +
> +There are also min() and max() macros that do strict type checking if you
> +need them.  Feel free to peruse that header file to see what else is already
> +defined that you shouldn't reproduce in your code.
> +
> +
> 
>  		Appendix I: References

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVBCA5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVBCA5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVBCAam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:30:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:30604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262718AbVBCA0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:26:31 -0500
Message-ID: <42016B55.4000804@osdl.org>
Date: Wed, 02 Feb 2005 16:07:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@in.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
Subject: Re: [Fastboot] [PATCH] Minor Kexec bug fix (2.6.11-rc2-mm2)
References: <1107352593.11609.146.camel@2fwv946.in.ibm.com>
In-Reply-To: <1107352593.11609.146.camel@2fwv946.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> Hi Andrew,
> 
> This patch has been generated against 2.6.11-rc2-mm2. This fixes a very
> minor bug in kexec.

Have you run sparse on a kexec-patched kernel tree?
I have, but not lately.  It needed some s/0/NULL/ in several places,
but that was before the latest big changes...

> diff -puN include/linux/kexec.h~kexec_minor_bug_fix include/linux/kexec.h
> --- linux-2.6.11-rc2-mm2-kdump/include/linux/kexec.h~kexec_minor_bug_fix	2005-02-02 16:28:18.000000000 +0530
> +++ linux-2.6.11-rc2-mm2-kdump-vivek/include/linux/kexec.h	2005-02-02 16:29:01.000000000 +0530
> @@ -79,7 +79,7 @@ struct kimage {
>  	unsigned long control_page;
>  
>  	/* Flags to indicate special processing */
> -	int type : 1;
> +	unsigned int type : 1;

-- 
~Randy

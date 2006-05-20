Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWETX1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWETX1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWETX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:27:50 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:9688
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964844AbWETX1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:27:49 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Ameer Armaly <ameer@bellsouth.net>
Subject: Re: [patch] initialize variables to reduce i386 warnings
Date: Sun, 21 May 2006 01:27:27 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.61.0605201919100.2160@sg1>
In-Reply-To: <Pine.LNX.4.61.0605201919100.2160@sg1>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605210127.27881.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 01:19, you wrote:
> Initialized cpu_freq in arch/i386/kernel/cpu/transmeta.c to suppress warning.

> index 9202b67..3a7e485 100644
> --- a/arch/i386/kernel/efi.c
> +++ b/arch/i386/kernel/efi.c
> @@ -270,8 +270,8 @@ void efi_memmap_walk(efi_freemem_callbac
>   {
>   	int prev_valid = 0;
>   	struct range {
> -		unsigned long start;
> -		unsigned long end;
> +		unsigned long start = 0;
> +		unsigned long end = 0;
>   	} prev, curr;

Did you actually try to compile the stuff before submission?

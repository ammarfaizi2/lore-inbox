Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWGaQOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGaQOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWGaQOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:14:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:15747 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030210AbWGaQOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:14:51 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=e9Hn78VSsQDL1ewDSS3qkHAwd1o9ZwEY3Vml+5NG56QehGm9MrfMcME7pbt6cqbu2
	MwW6v/ajbnvA9ALQH0i6A==
Message-ID: <44CE2C61.4010809@google.com>
Date: Mon, 31 Jul 2006 09:14:25 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: x86_64 compile spewing hundreds of warnings - started 2.6.15-git8
References: <440748FD.8010806@google.com>
In-Reply-To: <440748FD.8010806@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> between 2.6.15-git7 and 2.6.15-git8 we started getting hundreds of 
> compile warnings:
> 
> -git7: http://test.kernel.org/20295/debug/test.log.0
> -git8: http://test.kernel.org/20402/debug/test.log.0
> 
> Warnings look like this:
> 
> include/asm/bitops.h: In function `load_elf32_binary':
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> 
> 
> What do these mean? And how do we get rid of it?
> 
> Presumably caused by this:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=636dd2b7def5c9c72551b51d4d516a65c269de08 
> 
> 
> or this:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=92934bcbf96bc9dc931c40ca5f1a57685b7b813b 
> 
> 

There were rumblings about changing these checks around a bit, but
nothing happened and the warnings are still there ... any chance of
fixing this?

M.


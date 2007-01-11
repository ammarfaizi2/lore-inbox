Return-Path: <linux-kernel-owner+w=401wt.eu-S1030277AbXAKO5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbXAKO5x (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbXAKO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:57:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:7819 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030277AbXAKO5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:57:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XhSZHXaoT+6qu05mn2VsRnslJUfhX8HRHpAID4sLuJselidR4V4X5Cwf2HkQlpbUl3M+p5LDKxivvj1WFAlMtKPM4JrIMc1BZuYw3GHHyNfNM1xnAGCV588xqI8MUoOxfsUrA48Uly1dS8uCp8s+l4hlGrDcXnr4FRfRpV6T3/I=
Message-ID: <b6fcc0a0701110657j585aaf1fl599eb3c548ea7eb6@mail.gmail.com>
Date: Thu, 11 Jan 2007 17:57:50 +0300
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] net/wanrouter/wanmain.c: cleanups
Cc: "Andrew Morton" <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070111134938.GH20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070111134938.GH20027@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following cleanups:
> - make the following needlessly global functions static:
>   - lock_adapter_irq()
>   - unlock_adapter_irq()

These are 1:1 wrappers around spinlock_irqsave/restore. Just remove them.

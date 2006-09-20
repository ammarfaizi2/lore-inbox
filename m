Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWITUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWITUzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWITUzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:55:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19960 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751058AbWITUzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:55:01 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=P8nQWtS7fLl6iwPCq7heCu3SUu5RV7aUvASaAMQDT3/w9bQrwjuaWOI4H6r5vq2kL
	Uf2EB0b4XCN2OLGccF19g==
Message-ID: <404ea8000609201354p7313f35as7bbe63cc09a5fc3f@mail.google.com>
Date: Wed, 20 Sep 2006 13:54:57 -0700
From: "Dmitriy Zavin" <dmitriyz@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH 1/4] x86_64/i386 thermal mce: Refactor thermal throttle reporting.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200609200938.51215.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11587201623432-git-send-email-dmitriyz@google.com>
	 <11587201623187-git-send-email-dmitriyz@google.com>
	 <200609200938.51215.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, will move the mce_log part into mce.c in x86_64 and go back to
returning 0/1 from therm_throt_process. Then only the x86_64 thermal
mce will mcelog, and no #ifdefs :)

On 9/20/06, Andi Kleen <ak@suse.de> wrote:
>
> > +
> > +#include <linux/percpu.h>
> > +#include <linux/cpu.h>
> > +#include <asm/cpu.h>
> > +#include <linux/notifier.h>
> > +#include <asm/therm_throt.h>
> > +
> > +#ifdef CONFIG_X86_64
>
>
> Sorry, no such ifdefs allowed. That is what I meant with making the merged code
> worse than split code.
>
> -Andi
>

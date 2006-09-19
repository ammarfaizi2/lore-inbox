Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWISUFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWISUFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWISUFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:05:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:13502 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751101AbWISUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:05:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C7lEM2YvEascysB/TknKgWFeYiD7Pn0ck9jMZKMKZJlt+8qFbM5wJ+axbXOuUybTIGAFAIWUKphcZxs6Xf5Yj3TOkc8mPV8UyVUiTNOLC+KRbElwre4QZaQj22SQ+s5EzPLkvkDg7TgSLfBbai+5SmEolo3g8cT4kTDOyi33XlQ=
Message-ID: <45104DAC.2000000@gmail.com>
Date: Wed, 20 Sep 2006 00:06:04 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Scott E. Preece" <preece@motorola.com>
CC: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
References: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
In-Reply-To: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott E. Preece wrote:
> | From: Pavel Machek<pavel@ucw.cz>
> | 
> | > >>+struct powerop_driver {
> | > >>+	char *name;
> | > >>+	void *(*create_point) (const char *pwr_params, va_list args);
> | > >>+	int (*set_point) (void *md_opt);
> | > >>+	int (*get_point) (void *md_opt, const char *pwr_params, va_list 
> | > >>args);
> | > >>+};
> | > >
> | > >We can certainly get better interface than va_list, right?
> | > 
> | > Please elaborate.
> | 
> | va_list does not provide adequate type checking. I do not think it
> | suitable in driver<->core interface.
> ---
> 
> Well, in this particular case the typing probably has to be weak, one
> way or another. The meaning of the parameters is arguably opaque at
> the interface - the attributes may be meaningful to specific components
> of the system, but are not defined in the standardized interface (which
> would otherwise have to know about all possible kinds of power
> attributes and be changed every time a new one is added).
> 
> So, if you'd rather have an array of char* or void* values, that would
> probably also meet the need, but my guess is that the typing is
> intentionally opaque.

exactly. Thanks Scott, I don't have anything meaningful to add here.

> ---
> | ...
> | > >How is it going to work on 8cpu box? will
> | > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
> | > 
> | > i do not operate with term 'state' so I don't understand what it means here.
> | 
> | Okay, state here means "operating point". How will operating points
> | look on 8cpu box? That's 256 states if cpus only support "low" and
> | "high". How do you name them?
> ---
> 
> I don't think you would name the compounded states. Each CPU would need
> to have its own defined set of operating points (since the capabilities
> of the CPUs can reasonably be different).

i'm not sure - may be it's the mail list issues but in fact I sent out
my additional comment on this question in a separate letter on this thread
a while ago.

Eugeny

> scott


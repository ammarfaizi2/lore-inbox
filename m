Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVAGPOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVAGPOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVAGPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:14:21 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:59050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261450AbVAGPOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:14:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=h9wfm9PR9vjSHY8nv6rBDusab+Gmkb0l6xEly6wS/NRDYWe86K+vEMQONP6/WSBBX4Xtc1raajiMcDaPp8NlknxYLMLOtcjtgHYetdCqRYpQONlXpNK9MZIsO+eC7CBOM+hluyccC9N6Du+aOi/kwSq0awlNegnX6Ox5fysQNBQ=
Message-ID: <297f4e0105010707142be80168@mail.gmail.com>
Date: Fri, 7 Jan 2005 16:14:07 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent
In-Reply-To: <297f4e01050107065060e0b2ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <297f4e01050107065060e0b2ad@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next to this, there seems to be a mistake in the 2.6.10 changelog: it writes
[quote]
kobject_uevent(const char *signal,
	                 struct kobject *kobj,
	                 struct attribute *attr)
[/quote]
whilst include/linux/kobject_uevent.h defines
[quote]
int kobject_uevent(struct kobject *kobj,
                   enum kobject_action action,
                   struct attribute *attr);
[/quote]
which is something completely different.

On Fri, 7 Jan 2005 15:50:52 +0100, Ikke <ikke.lkml@gmail.com> wrote:
> One of the new features of 2.6.10 (well, AFAIK its new) is the
> kobject_uevent function set.
> Currently only some places send out events like this, so I was
> thinking to add some more.
> 
> Question is: how can I test this? Is there any userland program that
> catches these events and prints some information on them to the
> screen?
> 
> I found out Kay Siever and RML's (maybe some others too?) work on
> kernel->userspace events, but the syntax used there seems to be
> somewhat different. Kay's got a listener
> (http://vrfy.org/projects/kdbusd/kdbusd.c), but is this one
> compatible?
> 
> Regards, Ikke
>

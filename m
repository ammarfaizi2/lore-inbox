Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVAGRA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVAGRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVAGRA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:00:27 -0500
Received: from peabody.ximian.com ([130.57.169.10]:12193 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261507AbVAGRAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:00:12 -0500
Subject: Re: kobject_uevent
From: Robert Love <rml@novell.com>
To: Ikke <ikke.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <297f4e0105010707142be80168@mail.gmail.com>
References: <297f4e01050107065060e0b2ad@mail.gmail.com>
	 <297f4e0105010707142be80168@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 11:55:49 -0500
Message-Id: <1105116949.9311.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 16:14 +0100, Ikke wrote:

> Next to this, there seems to be a mistake in the 2.6.10 changelog: it writes
> [quote]
> kobject_uevent(const char *signal,
> 	                 struct kobject *kobj,
> 	                 struct attribute *attr)
> [/quote]
> whilst include/linux/kobject_uevent.h defines
> [quote]
> int kobject_uevent(struct kobject *kobj,
>                    enum kobject_action action,
>                    struct attribute *attr);
> [/quote]
> which is something completely different.

The signal as a string was replaced by the kobject_action enumeration,
which is mapped to a string.  It is just an attempt at providing type
safety.

	Robert Love



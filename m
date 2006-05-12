Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWELUCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWELUCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWELUCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:02:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58249 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbWELUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:02:21 -0400
Subject: Re: How to read BIOS information
From: Arjan van de Ven <arjan@infradead.org>
To: Dan Carpenter <error27.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b263e5900605100132m62cbfe16yda4213c97ae363e@mail.gmail.com>
References: <445F5228.7060006@wipro.com>
	 <1147099994.2888.32.camel@laptopd505.fenrus.org>
	 <b263e5900605100132m62cbfe16yda4213c97ae363e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 22:02:19 +0200
Message-Id: <1147464139.3173.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 01:32 -0700, Dan Carpenter wrote:
> Arjan van de Ven:
> > But that's the best you can do.
> > (well you could grovel through the acpi tables just like the kernel
> > does, but you really don't want to do that from userspace)
> 
> Obviously that would be tricky in this case.  But in general it seems
> like writing an acpi table parser should be  doable.  Couldn't you
> just search through /dev/mem like dmidecode does?  What's the
> difficult part?

the difficult part is in all the exceptions, quirks and special rules
the kernel uses (like "don't trust this table if acpi is off", and the
rules for acpi to not get enabled at runtime are highly complex and
continuously evolving). 


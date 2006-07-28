Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWG1S7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWG1S7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWG1S7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:59:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:62629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161238AbWG1S7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:59:33 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
Date: Fri, 28 Jul 2006 21:00:01 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607282045.05292.ak@suse.de> <1154112511.6416.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1154112511.6416.46.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282100.01783.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 20:48, Arjan van de Ven wrote:
> On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> >
> > Why can't you just use the normal call cc-option for this?
>
> this requires gcc 4.2; cc-option is not useful for that.

This means nearly nobody can use it. The CC option thing is also
very ugly.  Perhaps you really need a Makefile time check like
configure would do for it. Generating a .s and grepping for %gs 
would be enough I guess.

-Andi

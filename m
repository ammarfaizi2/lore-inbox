Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWI2TgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWI2TgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWI2TgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:36:14 -0400
Received: from xenotime.net ([66.160.160.81]:65496 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751356AbWI2TgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:36:13 -0400
Date: Fri, 29 Sep 2006 12:37:37 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-Id: <20060929123737.ec613178.rdunlap@xenotime.net>
In-Reply-To: <20060928191946.GC4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>
	<20060929113814.db87b8d5.rdunlap@xenotime.net>
	<20060928185820.GB4759@julia.computer-surgery.co.uk>
	<20060929121157.0258883f.rdunlap@xenotime.net>
	<20060928191946.GC4759@julia.computer-surgery.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 20:19:46 +0100 Roger Gammans wrote:

> On Fri, Sep 29, 2006 at 12:11:57PM -0700, Randy Dunlap wrote:
> > I don't know if or where it is documented.
> 
> Well, I've spend a good chunk of time reading round this part of
> the kernel's interfaces without spotting it so another note somewhere
> can't help.
> 
> > You can submit a patch for it.
> > If you don't, I'll put it in my todo queue.
> 
> If I find an approriate place to put such a note I'll add it and
> submit a patch, but I'm not sure where to put it , atm.
> 
> Any suggestions?

Hm, I looked thru fs/bio.c and block/*.c and Documentation/Docbook/*.tmpl.
The best place that I see to put it right now is in
include/linux/bio.h, struct bio, field: bi_sector.

What do you think of that?
---
~Randy
GPL v0:  http://www.glacierparkinc.com/GlacierParkLodge.htm

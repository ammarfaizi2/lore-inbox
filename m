Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274815AbTHPPpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHPPpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:45:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14341 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S274815AbTHPPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:45:10 -0400
Subject: Re: increased verbosity in dmesg
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: gene.heskett@verizon.net
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308161136.01133.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
	 <1061031726.623.3.camel@teapot.felipe-alfaro.com>
	 <200308161136.01133.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1061048708.624.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 17:45:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-16 at 17:36, Gene Heskett wrote:
> >In 2.6.0-test, the ring bugger size is configurable. Just look for
> >CONFIG_LOG_BUF_SHIFT. The kernel ring size will be
> >2^CONFIG_LOG_BUF_SHIFT bytes, so for a CONFIG_LOG_BUF_SHIFT of 14,
> >you'll 2^14 or 16 KBytes.
> 
> Which says that a setting of 15 would get 32k then.
> I take it this (for an i386 system) is the correct file to edit?

Yes, a value of 15 means 32KB. However, I don't recommend you setting
this value too high.

> kernel/ikconfig.h:CONFIG_LOG_BUF_SHIFT=14 \n\
> Mmmm, that says do not edit, auto-generated, so how about this one?
> 
> include/config/log/buf/shift.h
> 
> which contains only that single line.  Its now 15 & we'll see.

No, no, you'll need to edit the ".config" file to reflect the changes.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWHHRf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHHRf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWHHRf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:35:29 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:44968
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030199AbWHHRf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:35:28 -0400
From: Michael Buesch <mb@bu3sch.de>
To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [HW_RNG] How to use generic rng in kernel space
Date: Tue, 8 Aug 2006 19:34:31 +0200
User-Agent: KMail/1.9.1
References: <20060808153947.39735.qmail@web25804.mail.ukl.yahoo.com>
In-Reply-To: <20060808153947.39735.qmail@web25804.mail.ukl.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608081934.31694.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 17:39, moreau francis wrote:
> Michael Buesch wrote:
> > So, if you have a special hwrng on your embedded board and you
> > have some special driver in that board, why not interface
> > directly from the driver to the hwrng-driver?
> 
> This is what I'm currently doing. I was just thinking to use the
> new HW-RNG layer and drop common code...
> 
> > This is all pretty special case.
> > In the hwrng-driver you could still additionally do a
> > hrwng_register() to export the functionality to
> > userspace, though.
> > 
> 
> yes I would like to do that but there is a problem: I have no 
> access to "rng_mutex" to synchronise hw accesses and I'm
> wondering if there's any issue to use a mutex in driver init
> code.

Use your own mutex or spinlock in the data_read callback
and use that to serialize accesses to the hardware.

-- 
Greetings Michael.

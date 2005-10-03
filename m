Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVJCT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVJCT1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVJCT1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:27:05 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:17366 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932644AbVJCT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:27:04 -0400
Date: Mon, 3 Oct 2005 12:27:14 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [I2C] kmalloc + memset -> kzalloc conversion
Message-ID: <20051003192714.GA3686@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051001073631.GK25424@plexity.net> <3888a5cd0510010432h52ede401g6fe34b7f93a3c342@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3888a5cd0510010432h52ede401g6fe34b7f93a3c342@mail.gmail.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01 2005, at 13:32, Jiri Slaby was caught saying:
> On 10/1/05, Deepak Saxena <dsaxena@plexity.net> wrote:
> > +       iface = (struct keywest_iface *) kzalloc(tsize, GFP_KERNEL);
> cast isn't needed
> > +       if (!(smbuses = (void *)kzalloc(2*sizeof(struct nforce2_smbus),
> >                                         GFP_KERNEL)))
> cast from (void*) to (void*)? No...

Agree...but I'm just doing kzalloc changes for now and if I started
cleaning every piece of ugly or bloated code in the kernel, I would 
spend the rest of my life looking at drivers/ACPI.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.

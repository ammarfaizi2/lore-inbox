Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWAaHev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWAaHev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWAaHev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:34:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030282AbWAaHeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:34:50 -0500
Date: Mon, 30 Jan 2006 23:34:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.15.2
Message-Id: <20060130233427.5e7912ae.akpm@osdl.org>
In-Reply-To: <20060131070642.GA25015@kroah.com>
References: <20060131070642.GA25015@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> We (the -stable team) are announcing the release of the 2.6.15.2 kernel.
>

There remain some box-killing bugs:

- The scsi_cmd leak

- The BIO-uses-ZONE_DMA-hence-oom-killing bug

- A skbuff_head_cache leak causes oom-killings.

All of these only seem to affect a small minority of machines.

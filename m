Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWHGUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWHGUCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHGUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:02:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932335AbWHGUC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:02:29 -0400
Date: Mon, 7 Aug 2006 13:02:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Message-Id: <20060807130208.94b58773.akpm@osdl.org>
In-Reply-To: <20060807193836.GA4007@inferi.kami.home>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<20060807193836.GA4007@inferi.kami.home>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 21:38:36 +0200
Mattia Dongili <malattia@linux.it> wrote:

> after resume from ram (tested in single user), I can type commands for a
> few seconds (time is variable), the processes get stuck in io_schedule.
> Poorman's screenshots are here:
> http://oioio.altervista.org/linux/dsc03448.jpg
> http://oioio.altervista.org/linux/dsc03449.jpg

That probably measn that the device or device driver has got itself into a
sick state and IO completions aren't occurring. 

Which storage device (and which device driver) is being used here?

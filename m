Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVCMBXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVCMBXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVCMBXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 20:23:50 -0500
Received: from waste.org ([216.27.176.166]:63161 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261364AbVCMBX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 20:23:27 -0500
Date: Sat, 12 Mar 2005 17:23:23 -0800
From: Matt Mackall <mpm@selenic.com>
To: firefly blue <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 : physical memory address and pid
Message-ID: <20050313012323.GE3163@waste.org>
References: <17d798805031217055a3e9cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d798805031217055a3e9cc6@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 08:05:11PM -0500, firefly blue wrote:
> Hi,
> 
> With the 2.6 Linux kernel, I want to find, from the physical page
> frame, the virtual address of the page loaded in the frame and the
> process id of the process owning it.

Follow struct page->mapping to struct address_space. A page can be
mapped into any number of processes and multiple times per process so
you'll need to walk the data structures there.

-- 
Mathematics is the supreme nostalgia of our time.

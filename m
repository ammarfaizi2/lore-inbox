Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJJIp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJJIp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 04:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJJIp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 04:45:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47325 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750717AbVJJIp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 04:45:58 -0400
Date: Mon, 10 Oct 2005 10:45:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051010084535.GA2298@elf.ucw.cz>
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com> <20051006.211718.74749573.noboru.obata.ar@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006.211718.74749573.noboru.obata.ar@hitachi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> FULL DUMP WITH COMPRESSION
> ==========================
> 
> Those who still want a full dump, including me, are interested
> in dump compression.  For example, the LKCD format (at least v7
> format) supports pagewise compression with the deflate
> algorithm.  A dump analyze tool "crash" can transparently
> analyze the compressed dump file in this format.
> 
> The compression will reduce the storage space at certain degree,
> and may also reduce the time if a dump process were I/O bounded.

I'd say that compression does not help much, it can only speed it up
twice. But...

> 
> WHICH IS BETTER?
> ================
> 
> I wrote a small compression tool for LKCD v7 format to see how
> effective the compression is, and it turned out that the time
> and size of compression were very much similar to that of gzip,
> not surprisingly.
> 
> Compressing a 32GB dump file took about 40 minutes on Pentium 4
> Xeon 3.0GHz, which is not good enough because the dump without
> compression took only 5 minutes; eight times slower.

....you probably want to look at suspend2.net project. They have
special compressor aimed at compressing exactly this kind of data,
fast enough to be improvement.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

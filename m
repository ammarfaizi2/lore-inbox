Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWHWMBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWHWMBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWHWMBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:01:37 -0400
Received: from brick.kernel.dk ([62.242.22.158]:38706 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932435AbWHWMBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:01:36 -0400
Date: Wed, 23 Aug 2006 14:03:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
Message-ID: <20060823120355.GD5893@suse.de>
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823113317.722640313@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23 2006, Akinobu Mita wrote:
> This patch provides fail-injection capability for disk IO.
> 
> Boot option:
> 
> 	fail_make_request=<probability>,<interval>,<times>,<space>
> 
> 	<probability>
> 
> 		specifies how often it should fail in percent.
> 
> 	<interval>
> 
> 		specifies the interval of failures.
> 
> 	<times>
> 
> 		specifies how many times failures may happen at most.
> 
> 	<space>
> 
> 		specifies the size of free space where disk IO can be issued
> 		safely in bytes.
> 
> Example:
> 
> 	fail_make_request=100,10,-1,0
> 
> generic_make_request() fails once per 10 times.

Hmm dunno, seems a pretty useless feature to me. Wouldn't it make a lot
more sense to do this per-queue instead of a global entity?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319490AbSH3IV2>; Fri, 30 Aug 2002 04:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319491AbSH3IV2>; Fri, 30 Aug 2002 04:21:28 -0400
Received: from dp.samba.org ([66.70.73.150]:19924 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319490AbSH3IV1>;
	Fri, 30 Aug 2002 04:21:27 -0400
Date: Fri, 30 Aug 2002 18:24:56 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@zip.com.au, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020830082456.GC10656@krispykreme>
References: <20020830015814.GN18114@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830015814.GN18114@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, I have *had it* with statm_pgd_range()!

On a related note, it would be nice if procps would not parse things it
doesnt need:

strace ps 2>&1 | grep open | grep '/proc'

open("/proc/12467/stat", O_RDONLY)      = 7
open("/proc/12467/statm", O_RDONLY)     = 7
open("/proc/12467/status", O_RDONLY)    = 7
open("/proc/12467/cmdline", O_RDONLY)   = 7
open("/proc/12467/environ", O_RDONLY)   = 7

It always opens statm even when its not required.

Anton

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319493AbSH3I0n>; Fri, 30 Aug 2002 04:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319494AbSH3I0n>; Fri, 30 Aug 2002 04:26:43 -0400
Received: from holomorphy.com ([66.224.33.161]:27783 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319493AbSH3I0m>;
	Fri, 30 Aug 2002 04:26:42 -0400
Date: Fri, 30 Aug 2002 01:31:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au,
       riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020830083100.GQ18114@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@zip.com.au, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <20020830082456.GC10656@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020830082456.GC10656@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Okay, I have *had it* with statm_pgd_range()!

On Fri, Aug 30, 2002 at 06:24:56PM +1000, Anton Blanchard wrote:
> On a related note, it would be nice if procps would not parse things it
> doesnt need:
> strace ps 2>&1 | grep open | grep '/proc'
> open("/proc/12467/stat", O_RDONLY)      = 7
> open("/proc/12467/statm", O_RDONLY)     = 7
> open("/proc/12467/status", O_RDONLY)    = 7
> open("/proc/12467/cmdline", O_RDONLY)   = 7
> open("/proc/12467/environ", O_RDONLY)   = 7
> It always opens statm even when its not required.
> Anton

Userspace is FITH, it only needs to do it for BSD-style stuff reporting
RSS/vsz. vsz is wrong anyway if it doesn't open /proc/$PID/maps.


Cheers,
Bill

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSGPJNd>; Tue, 16 Jul 2002 05:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSGPJNc>; Tue, 16 Jul 2002 05:13:32 -0400
Received: from holomorphy.com ([66.224.33.161]:61057 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S311898AbSGPJNa>;
	Tue, 16 Jul 2002 05:13:30 -0400
Date: Tue, 16 Jul 2002 02:16:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716091622.GD1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au> <20020716085233.GA1096@holomorphy.com> <3D33E532.E078914E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D33E532.E078914E@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> From watching /proc/meminfo it was clear that there were only 1MB or
>> 2MB under writeback, but it also showed that the dirty memory thresholds
>> were being exceeded.

On Tue, Jul 16, 2002 at 02:19:46AM -0700, Andrew Morton wrote:
> Ah, that may well happen with loop.  Mark a page clean, "submit"
> it and that just goes and marks a different page dirty.
> If you could please share the setup details (amount of memory,
> file sizes, workload etc) I'll have a look.

The box is an IBM Thinkpad with 256MB of RAM and a 900MHz P-III cpu.
No-name IDE disk (believe me, I made sure everything there was expendable), 
workload being dbench 16 on reiserfs over loop with a 256MB reiserfs loop
file. I'm actually not entirely sure what the filesizes were as dbench
didn't report that.


Cheers,
Bill

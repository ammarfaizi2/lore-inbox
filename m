Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQJ3HDR>; Mon, 30 Oct 2000 02:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQJ3HDH>; Mon, 30 Oct 2000 02:03:07 -0500
Received: from slc1179.modem.xmission.com ([166.70.8.163]:51474 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129030AbQJ3HCz>; Mon, 30 Oct 2000 02:02:55 -0500
To: joeja@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc & xml data
In-Reply-To: <39FCDB16.B0955558@mindspring.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Oct 2000 23:54:24 -0700
In-Reply-To: Joe's message of "Sun, 29 Oct 2000 21:21:11 -0500"
Message-ID: <m1n1fmhl9b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe <joeja@mindspring.com> writes:

> I remember hearing about various debates about the /proc structure.  I
> was wondering if anyone had ever considered storing some of the data in
> xml format rather than its current format?  Things like /proc/meminfo
> and cpuinfo may work good in this format as then it would be easy to
> write a generic xml parser that could then be used to parse any of the
> data. "MemTotal:  %8lu kB\n"
> 
> In the case of the meminfo it would be a matter of changing the lines in
> fs/proc/array.c  function get_meminfo(char * buffer) from
> 
> "MemTotal:  %8lu kB\n"
> 
> to something like
> 
> "<memtotal>%8lu kB</memtotal>\n"

The general consensus is that if we have a major reorganization, in proc
the rule will be one value per file.  And let directories do the grouping.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbTCPIk3>; Sun, 16 Mar 2003 03:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbTCPIk3>; Sun, 16 Mar 2003 03:40:29 -0500
Received: from holomorphy.com ([66.224.33.161]:19413 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262622AbTCPIk2>;
	Sun, 16 Mar 2003 03:40:28 -0500
Date: Sun, 16 Mar 2003 00:50:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030316085045.GN1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m365qk1gzx.fsf@lexa.home.net> <20030315135158.6d5fef1a.akpm@digeo.com> <20030315220618.GY20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315220618.GY20188@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 01:51:58PM -0800, Andrew Morton wrote:
>> hm, I wonder if this should be in a separate cacheline.  We may as well use a
>> single lock if they're this close together.  Bill, can you test that
>> sometime?

On Sat, Mar 15, 2003 at 02:06:18PM -0800, William Lee Irwin III wrote:
> Benching now.

Sorry, this should have hit the list earlier.

Throughput 294.388 MB/sec 128 procs
dbench 128  87.22s user 4286.79s system 2984% cpu 2:26.58 total

(the "before" picture was ca. 257MB/s)

vmstat and oprofile info vanished, not sure why. A rerun is possible.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUHER3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUHER3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267797AbUHER3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:29:12 -0400
Received: from holomorphy.com ([207.189.100.168]:63940 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267796AbUHER24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:28:56 -0400
Date: Thu, 5 Aug 2004 10:25:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Mr. Berkley Shands" <berkley@dssimail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040805172531.GC17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Mr. Berkley Shands" <berkley@dssimail.com>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41126811.7020607@dssimail.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 12:02:09PM -0500, Mr. Berkley Shands wrote:
> Two severe disk read bugs:
> In a nutshell (see attached for gory details). Moving from 2.6.6 to 
> 2.6.7 dropped multi-threaded RAID0
> read performance from 429MB/Sec to 81MB/Sec. Single threaded reads 
> improved  368MB/Sec to 418MB/Sec.
> The code in drivers/md has no effect on this problem. Clearly this is a 
> thread access issue. Redhat ES3.0
> on x86_64 or i686.  The underlying hardware is capable of 955MB/Sec disk 
> reads off 28 drives,
> 541MB/Sec off 14 drives. Tuning I/O block size (11KB to 239KB) and 
> BLKRASET size (448 to 1024 or more)
> helps a little. System idle goes from 0% to 50% (2.6.6 to 2.6.8-rc3).

By any chance could you do binary search on the bk snapshots between
2.6.6 and 2.6.7?


-- wli

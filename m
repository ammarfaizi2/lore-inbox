Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVGNJmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVGNJmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVGNJmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:42:07 -0400
Received: from mx.wurtel.net ([195.64.88.114]:32274 "EHLO mx.wurtel.net")
	by vger.kernel.org with ESMTP id S262986AbVGNJmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:42:06 -0400
Date: Thu, 14 Jul 2005 11:41:45 +0200
From: Paul Slootman <paul+nospam@wurtel.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops when running mkreiserfs on large (9TB) raid0 set on AMD64 SMP
Message-ID: <20050714094145.GB383@wurtel.net>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20050713084152.GA5765@wurtel.net> <17109.37988.800325.47795@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17109.37988.800325.47795@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
X-Scanner: exiscan *1Dt0Dx-0007nK-00*.knaV9hxzAw*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Jul 2005, Neil Brown wrote:
> > Aug  9 20:09:18 localhost kernel: <ffffffff8808eb98>{:raid0:raid0_make_request+472}
> 
> Looks like the problem is at:
> 		sector_div(x, (unsigned long)conf->hash_spacing);
> 		zone = conf->hash_table[x];
[...]
> Anyway, the following patch, if it compiles, might changed the
> behaviour of raid0 -- possibly even improve it :-)
> 
> Thanks for the report.
> 
> Success/failure reports of this patch would be most welcome.

Thanks for the quick fix. I just tried it again with your patch,
and now it works fine!

Filesystem            Size  Used Avail Use% Mounted on
/dev/md11             8.8T   33M  8.8T   1% /mnt

Very nice... :)


Paul Slootman

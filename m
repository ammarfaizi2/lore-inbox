Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVILRUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVILRUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVILRUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:20:06 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:1727 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1751075AbVILRUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:20:05 -0400
Date: Mon, 12 Sep 2005 10:24:26 -0700
From: Jim McCloskey <mcclosk@ucsc.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Jim McCloskey <mcclosk@ucsc.edu>, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
Message-ID: <20050912172426.GA2882@branci40>
References: <20050912091021.GA2859@branci40> <20050912025120.4016c36b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912025120.4016c36b.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux/2.6.13 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:

  |>  In a 2.6.13 tree could you please do
  |>  
  |>  wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/broken-out/mtrr-suspend-resume-cleanup.patch
  |>  patch -p1 -R < mtrr-suspend-resume-cleanup.patch
  |>  
  |>  and retest?

Thank you very much. Unfortunately, this doesn't seem to have had any
effect, as far as I can see:

----------------------------------------------------------------------
/proc/mtrr:

reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1

/var/log/syslog:

Sep 12 10:09:10 localhost kernel: mtrr: type mismatch for
e8000000,8000000 old: write-back new: write-combining

/var/log/Xorg.0.log

(WW) RADEON(0): Failed to set up write-combining range (0xe8000000,0x8000000)
----------------------------------------------------------------------

Jim

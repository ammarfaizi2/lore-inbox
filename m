Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUFJGKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUFJGKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJGKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:10:33 -0400
Received: from holomorphy.com ([207.189.100.168]:22153 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266186AbUFJGK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:10:29 -0400
Date: Wed, 9 Jun 2004 23:10:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Clint Byrum <cbyrum@spamaps.org>
Cc: Ray Lee <ray-lk@madrabbit.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 vm/elevator loading down disks where 2.4 does not
Message-ID: <20040610061024.GW1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Clint Byrum <cbyrum@spamaps.org>, Ray Lee <ray-lk@madrabbit.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1086829384.13085.10.camel@orca.madrabbit.org> <EAAE7256-BAA3-11D8-B30D-000A95730E92@spamaps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EAAE7256-BAA3-11D8-B30D-000A95730E92@spamaps.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:03:38PM -0700, Clint Byrum wrote:
> That brings up an interesting point... is there a system wide stat that 
> tells me how effective the file cache is? I guess majfaults/s fits that 
> bill to some degree.

/proc/vmstat should log global major/minor fault counters (actually
summed on the fly per-cpu counters). I fixed those to properly report
major and minor faults for 2.6. The analogous numbers where they are
present are completely and utterly meaningless gibberish in 2.4.


-- wli

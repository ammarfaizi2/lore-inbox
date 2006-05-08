Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWEHG3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWEHG3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEHG3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:29:13 -0400
Received: from proof.pobox.com ([207.106.133.28]:12174 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932333AbWEHG3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:29:13 -0400
Date: Mon, 8 May 2006 01:29:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060508062905.GA9344@localdomain>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> To remove multiple CPUs, we should iteratively do single cpu removal.
> If tasks and interrupts are migrated to a cpu which will be soon
> removed, then we will trash tasks and interrupts again. The following
> patches allow remove several cpus one time. It's fast and avoids
> unnecessary repeated trash tasks and interrupts. This will help NUMA
> style hardware removal and SMP suspend/resume. Comments and suggestions
> are appreciated.

Some quantification of the benefits of adding this complexity would be
appreciated.  Like, how long does it take to offline all the cpus in a
node serially, and how much faster is the bulk method?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUHaKRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUHaKRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHaKRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:17:20 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:18351 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S267725AbUHaKRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:17:18 -0400
Date: Tue, 31 Aug 2004 12:16:20 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040831101620.GA5329@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
	albert@users.sourceforge.net
References: <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829120733.455f0c82.pj@sgi.com> <20040829191707.GU5492@holomorphy.com> <20040829194926.GA3289@k3.hellgate.ch> <20040829202543.GV5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829202543.GV5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 13:25:43 -0700, William Lee Irwin III wrote:
> > The list for the nproc user could be prepared based on the bit field
> > (or simply memcpy'd), no tasklist_lock or walking linked lists required.
> > What am I missing?
> 
> The pid bitmap could be exported to userspace rather easily.

I implemented an "all processes" selector based on that. Remaining pieces
are access control and a method for dumping large amounts of data (10 -
1000 KB) to user space.

Roger

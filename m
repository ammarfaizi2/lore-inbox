Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUHMTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUHMTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUHMTam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:30:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:46792 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266916AbUHMT3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:29:04 -0400
Date: Fri, 13 Aug 2004 21:28:57 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: davem@redhat.com, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       greearb@candelatech.com
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040813212857.7dd50320.ak@suse.de>
In-Reply-To: <20040813115140.0f09d889@dell_ss3.pdx.osdl.net>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040812124854.646f1936.davem@redhat.com>
	<20040813115140.0f09d889@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 11:51:40 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Here is another alternative, using tansworthe generator.  It uses percpu
> state. The one small semantic change is the net_srandom() only affects
> the current cpu's seed.  The problem was that having it change all cpu's
> seed would mean adding locking 

I would just update the other CPUs without locking. Taking
a random number from a partially updated state shouldn't be a big 
issue.

-Andi


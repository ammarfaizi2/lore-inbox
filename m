Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWIUU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWIUU5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWIUU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:57:09 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:45070 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750968AbWIUU5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:57:06 -0400
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="323922202:sNHT30390248"
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Bill Waddington <william.waddington@beezmo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Flushing writes to PCI devices
X-Message-Flag: Warning: May contain useful information
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
	<Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
	<fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
	<6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
	<1158862442.29551.22.camel@sardonyx>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 21 Sep 2006 13:56:59 -0700
In-Reply-To: <1158862442.29551.22.camel@sardonyx> (Bryan O'Sullivan's message of "Thu, 21 Sep 2006 11:14:02 -0700")
Message-ID: <adavenhgcpw.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Sep 2006 20:57:05.0042 (UTC) FILETIME=[7E618F20:01C6DDC0]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Yes.  If your device requires that writes to some locations
    Bryan> in MMIO space be performed in a specific order, you must
    Bryan> explicitly do this in your driver.  Intel CPUs will flush
    Bryan> posted writes out of order, for example.

Really?  Just normal posted PCI writes without using MTRRs or
write-combining or anything like that?

That doesn't seem right to me, and I would expect all sorts of things
to break if it were true.

 - R.

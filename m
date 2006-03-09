Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWCIXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWCIXgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCIXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:36:39 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:60243 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1752056AbWCIXgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:36:37 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
X-Message-Flag: Warning: May contain useful information
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
	<adau0a7fbzf.fsf@cisco.com>
	<1141946942.10693.36.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:36:34 -0800
In-Reply-To: <1141946942.10693.36.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:29:02 -0800")
Message-ID: <adaveundwcd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:36:35.0118 (UTC) FILETIME=[4DA044E0:01C643D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> It's purely a performance optimisation.  Since we tune very
    Bryan> closely to each CPU, there's no point right now in
    Bryan> sort-of-tuning for a CPU that doesn't yet exist :-)

I thought that if ipath_unordered_wc() returns false then you assume
the writes through a WC mapping go in order.  If Via behaves like
Intel and reorders writes, but ipath_unordered_wc() returns false,
then won't your driver break in a subtle way?

 - R.

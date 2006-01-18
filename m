Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWARWF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWARWF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWARWF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:05:28 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27098 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932535AbWARWF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:05:27 -0500
Date: Wed, 18 Jan 2006 17:01:22 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
Message-ID: <20060118220122.GH16285@kvack.org>
References: <20060118214204.GG16285@kvack.org> <Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:57:30PM -0500, Alan Stern wrote:
> Sez who?  If it's not documented in the kernel source, I don't believe 
> it.

The notifier interface is supposed to be *light weight*.  Adding locks 
that get taken on every call basically changes the concept entirely.  The 
cache misses notifiers add are measurable overhead, with locks being far 
worse.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.

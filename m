Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCKStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCKStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVCKSoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:44:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261291AbVCKSZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:25:05 -0500
Date: Fri, 11 Mar 2005 13:25:00 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm counter operations through macros
Message-ID: <20050311182500.GA4185@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 04:23:21AM -0800, Christoph Lameter wrote:
 > This patch extracts all the operations on counters protected by the
 > page table lock (currently rss and anon_rss) into definitions in
 > include/linux/sched.h. All rss operations are performed through
 > the following three macros:
 > 
 > get_mm_counter(mm, member)		-> Obtain the value of a counter
 > set_mm_counter(mm, member, value)	-> Set the value of a counter
 > update_mm_counter(mm, member, value)	-> Add a value to a counter

Splitting this last one into inc_mm_counter() and dec_mm_counter()
means you can kill off the last argument, and get some of the
readability back. As it stands, I think this patch adds a bunch
of obfuscation for no clear benefit.

		Dave


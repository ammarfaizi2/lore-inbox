Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVL0UVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVL0UVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVL0UVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 15:21:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4551 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751136AbVL0UVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 15:21:51 -0500
Date: Tue, 27 Dec 2005 12:21:38 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ravikiran Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded
  process at getrusage()
In-Reply-To: <43AD8AF6.387B357A@tv-sign.ru>
Message-ID: <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com>
References: <43AD8AF6.387B357A@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2005, Oleg Nesterov wrote:

> I can't understand this. 'p' can do clone(CLONE_THREAD) immediately
> after 'if (!thread_group_empty(p))' check.

Only if p != current. As discussed later the lockless approach is 
intened to only be used if p == current.

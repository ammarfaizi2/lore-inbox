Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWACSSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWACSSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWACSSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:18:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:34446 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932384AbWACSSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:18:32 -0500
Date: Tue, 3 Jan 2006 10:18:14 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Shai Fultheim <shai@scalex86.org>,
       Nippun Goel <nippung@calsoftinc.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single
 threadedprocess at getrusage()
In-Reply-To: <20051228225752.GB3755@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601031014390.20750@schroedinger.engr.sgi.com>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com>
 <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain>
 <20051228225752.GB3755@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still think that it would be best to not handle __user pointers in 
getrusage_*. Alternatively lets give up on these smaller functions 
if the modifications are simple. Modify the existing function as Oleg 
suggested.

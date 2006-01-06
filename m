Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752508AbWAFRXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbWAFRXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbWAFRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:23:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:35507 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1752500AbWAFRXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:23:41 -0500
Date: Fri, 6 Jan 2006 09:23:30 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Shai Fultheim <shai@scalex86.org>,
       Nippun Goel <nippung@calsoftinc.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single
 threadedprocess at getrusage()
In-Reply-To: <20060106094627.GA4272@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com>
 <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain>
 <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru>
 <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru>
 <20060106094627.GA4272@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Ravikiran G Thirumalai wrote:

> +	need_lock = !(p == current && thread_group_empty(p));

Isnt 

need_lock = (p != current || !thread_group_empty(b))

clearer?

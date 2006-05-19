Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWESB1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWESB1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWESB1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:27:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52703 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932123AbWESB1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:27:11 -0400
Date: Thu, 18 May 2006 18:26:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-Id: <20060518182655.2d6a94e2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605181803090.22861@schroedinger.engr.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
	<20060517222543.600cb20a.akpm@osdl.org>
	<20060518175838.1c287d60.pj@sgi.com>
	<Pine.LNX.4.64.0605181803090.22861@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> I think this is another case demonstrating that alloc_pages() behavior is 
> way too complex right now.

One could certainly use this thread as evidence to support that case ;).

And your thoughts are all the more reason to fix this bug we have now,
with a small, focused fix (to avoid possibly sleeping with interrupts
off), and then take our time with any rework, perhaps in the context of
the bigger changes you, Dave and Nick were discussing.

Good luck.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

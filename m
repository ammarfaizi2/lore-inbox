Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJGOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJGOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUJGOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:44:28 -0400
Received: from jade.aracnet.com ([216.99.193.136]:8583 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266703AbUJGOo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:44:26 -0400
Date: Thu, 07 Oct 2004 07:41:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rick Lindsley <ricklind@us.ibm.com>, Paul Jackson <pj@sgi.com>
cc: colpatch@us.ibm.com, Simon.Derr@bull.net, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
Message-ID: <1249520000.1097160060@[10.10.2.4]>
In-Reply-To: <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
References: <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     * Interrupts are not under consideration right now. They land where
>       they land, and this may affect exclusive sets.  If this is a
>       problem, for now, you simply lay out your hardware and exclusive
>       sets more intelligently.

They're easy to fix, just poke the values in /proc appropriately (same
as cpus_allowed, exactly).
 
>     * Memory allocation has a tendency and preference, but no hard policy
>       with regards to where it comes from.  A task which starts on one
>       part of the system but moves to another may have all its memory
>       allocated relatively far away.  In unusual cases, it may acquire
>       remote memory because that's all that's left.  A memory allocation
>       policy similar to cpus_allowed might be needed. (Martin?)

The membind API already does this.

M.

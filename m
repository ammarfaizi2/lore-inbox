Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCQX71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCQX71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCQX71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:59:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:40656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261270AbVCQX7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:59:23 -0500
Date: Thu, 17 Mar 2005 15:59:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-Id: <20050317155908.56e77b8e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	<20050317140831.414b73bb.akpm@osdl.org>
	<Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
	<20050317151151.47fd6e5f.akpm@osdl.org>
	<Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 17 Mar 2005, Andrew Morton wrote:
> 
>  > > > It's hard to know what to think about this without benchmarking numbers.
> 
>  http://oss.sgi.com/projects/page_fault_performance/

Oh no, not that page again ;)

Seems to say that prezeroing makes negligible difference to kernel builds,
but speeds up a big malloc+memset by 3x to 4x, yes?

Are there any real-worldish workloads which show an appreciable benefit?

The large speedup for a big memset seems odd - I assume it's simply
transferring CPU load from the user's process over to kscrubd.  Or is it
the fancy page-zeroing hardware?  How do we differentiate the two?

Are there any workloads which are seeing a benefit on a CPU which doesn't
have the zeroing hardware?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbULCTuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbULCTuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbULCTua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:50:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28310 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262488AbULCTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:47:38 -0500
Date: Fri, 3 Dec 2004 13:47:13 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: devik <devik@cdi.cz>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
Subject: Re: [PATCH] sched isolcpus=1 related OOPS in 2.6.9
Message-ID: <20041203194713.GB16069@sgi.com>
References: <41B09FFD.6070706@osdl.org> <Pine.LNX.4.33.0412031907271.493-200000@devix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0412031907271.493-200000@devix>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 07:15:58PM +0100, devik wrote:
> A patch is attached which fixes problems with isolated
> domains for me. I hope it is correct :-) I will try on
Martin,

After a quick look, this patch looks OK (although I haven't had a chance to
test it yet).  I don't know what what was intended with a default cpu_power
of 0, but I don't believe that a value of SCHED_LOAD_SCALE should negatively
affect the isolated domains (versus any other value).

Note that sched_init() does use SCHED_LOAD_SCALE as a default.


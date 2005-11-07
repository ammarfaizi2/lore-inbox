Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVKGRpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVKGRpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVKGRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:45:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:13236 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964888AbVKGRpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:45:19 -0500
Date: Mon, 7 Nov 2005 09:41:06 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Magnus Damm <magnus.damm@gmail.com>
cc: torvalds@osdl.org, akpm@osdl.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
In-Reply-To: <aec7e5c30511062335n96c229bve39f614bb8fc7e73@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0511070940220.19630@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
  <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
 <aec7e5c30511062335n96c229bve39f614bb8fc7e73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Magnus Damm wrote:

> It looks like the V4 to V5 upgrade added -ENOENT as return value to
> __isolate_lru_page(), but did not change the code in
> isolate_lru_pages().

Yuck. You are right.
 
> The fix for this is simple, but maybe something else needs to be
> changed too or I'm misunderstanding what is happening here.

No the fix should simply be replacing the -1 by -ENOENT.


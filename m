Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162130AbWKPAu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162130AbWKPAu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162133AbWKPAu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:50:59 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36826 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1162132AbWKPAu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:50:58 -0500
Date: Thu, 16 Nov 2006 09:54:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mbligh@mbligh.org, steiner@sgi.com, krafft@de.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
Message-Id: <20061116095429.0e6109a7.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost>
	<20061115193437.25cdc371@localhost>
	<Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
	<20061115215845.GB20526@sgi.com>
	<Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
	<455B9825.3030403@mbligh.org>
	<Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 14:52:43 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Wed, 15 Nov 2006, Martin Bligh wrote:
> 
> > All we need is an appropriate zonelist for each node, pointing to
> > the memory it should be accessing.
> 
> But there is no memory on the node. Does the zonelist contain the zones of 
> the node without memory or not? We simply fall back each allocation to the 
> next node as if the node was overflowing?
> 
yes. just fallback.
The zonelist[] donen't contain empty-zone.

-Kame


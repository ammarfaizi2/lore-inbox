Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTDNVk3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDNVk2 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:40:28 -0400
Received: from [12.47.58.203] ([12.47.58.203]:36351 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263944AbTDNVjJ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:39:09 -0400
Date: Mon, 14 Apr 2003 14:50:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: BUGed to death
Message-Id: <20030414145028.2b37e226.akpm@digeo.com>
In-Reply-To: <20030414210856.GA10688@suse.de>
References: <80690000.1050351598@flay>
	<20030414210006.GA7831@suse.de>
	<92940000.1050353740@flay>
	<20030414210856.GA10688@suse.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 21:50:52.0034 (UTC) FILETIME=[EAFB7620:01C302CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Mon, Apr 14, 2003 at 01:55:40PM -0700, Martin J. Bligh wrote:
> 
>  > True - however I should have included some more info ... Andrew worked
>  > out that some of the hottest ones lead to a null ptr dereference
>  > immediately afterwards anyways, so they're actually pointless.
> 
> Erk, that doesn't sound good. Example ?
> 

	if (foo == NULL)
		BUG();
	*foo = bar;

The BUG is a waste of space.


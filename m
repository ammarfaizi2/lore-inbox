Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTEQI5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTEQI5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:57:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29511 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261315AbTEQI5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:57:05 -0400
Date: Sat, 17 May 2003 09:09:51 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: time interpolation hooks
Message-ID: <20030517090951.D31765@devserv.devel.redhat.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030516142311.3844ee97.akpm@digeo.com>; from akpm@digeo.com on Fri, May 16, 2003 at 02:23:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 02:23:11PM -0700, Andrew Morton wrote:

I rather would have a "timer source" object that
provides those 2 functions as methods, so that one can write "timer" drivers
as more or less stand alone units that register themselves
with the generic timekeeping unit (probably with an accuracy score so that
the generic code can pick one in the event of multiple timer sources). 
For x86 I wrote an acpitimer "driver" last week (for 2.4) and it
gets messy if you have those 2 functions as just independent
function pointers ....

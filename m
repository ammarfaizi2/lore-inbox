Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUIIGic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUIIGic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUIIGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:38:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62094 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269358AbUIIGia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:38:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: george@mvista.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
Date: Wed, 8 Sep 2004 23:37:30 -0700
User-Agent: KMail/1.7
Cc: john stultz <johnstul@us.ibm.com>, Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <1094700768.29408.124.camel@cog.beaverton.ibm.com> <413FDC9F.1030409@mvista.com>
In-Reply-To: <413FDC9F.1030409@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409082337.30961.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 8, 2004 9:31 pm, George Anzinger wrote:
> a.) resolution.  If you don't put a limit on this you will invite timer
> storms. Currently, by useing 1/HZ resolution, all timer "line up" on ticks
> and reduce the interrupt overhead that would occure if we actually tried to
> give "exactly" what was asked for.  This is a matter of math and can be
> handled (assuming we resist the urge to go shopping :))

This can be bad though if lots of CPUs hit it at the same time or nearly so if 
they're all trying to write the same cacheline or two.

Jesse

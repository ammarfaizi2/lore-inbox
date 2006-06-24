Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933180AbWFXCH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbWFXCH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWFXCH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:07:58 -0400
Received: from mail.gmx.de ([213.165.64.21]:7625 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933180AbWFXCH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:07:57 -0400
X-Authenticated: #5039886
Date: Sat, 24 Jun 2006 04:07:56 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060624020755.GA6139@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Danial Thom <danial_thom@yahoo.com>, linux-kernel@vger.kernel.org
References: <20060622162141.GC14682@harddisk-recovery.com> <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.22 09:58:08 -0700, Danial Thom wrote:
> And 75K pps may not be "much", but its still at
> least 10% of what the system can handle, so it
> should measure around a 10% load. 2.4 measures
> about 12% load. So the only conclusion is that
> load accounting is broken in 2.6.

Are you by chance using procps < 3.1.12? The kernel reports absolute
values for cpu usage, the conversion to percentage is done by top/vmstat
itself. And those old versions don't know about the new fields that 2.6
kernels have in /proc/stat, thus they simply ignore the si and hi
values, producing quite misleading results...

Björn

PS: procps 3.1.12 was released in 2003, so if DEC was stone age and my
assumption about your tools holds, then your tools are like... medieval :)

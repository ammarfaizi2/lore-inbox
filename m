Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbWASSWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWASSWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWASSWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:22:38 -0500
Received: from relay01.pair.com ([209.68.5.15]:7941 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1161176AbWASSWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:22:36 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "scientica (GMail)" <scientica@gmail.com>
Subject: Re: scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM killer problems lately?)
Date: Thu, 19 Jan 2006 12:22:08 -0600
User-Agent: KMail/1.9
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200601181951.16708.chase.venters@clientec.com> <200601190334.25712.chase.venters@clientec.com> <43CFD6D6.2040700@gmail.com>
In-Reply-To: <43CFD6D6.2040700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191222.30441.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 12:13, scientica (GMail) wrote:
> Just out of curiosity, what's the slab? and what is the expected size
> of it? I just checked mine and it seems to eat some 304596 kB
> (2.6.14-ck4, soon 68d uptime). The only problems I've had recently is
> firefox crashing more than it should (but it could simply be me having
> a billion or so windows and tabs open, and it's the
> mozilla-firefox-bin-1.5-r2 from portage which is masked ~amd64, so
> it's probably just buggy - it dies with a segfault after beeing stuck
> at 100% CPU for a while, cant see any OOM-messages anywhere), other
> than that I've been able to both emerge stuff (nice'd though),
> download stuff and burn backups DVD's with out problems -
> simultaneously - and the system was still responsive :)

The slab layer in the kernel is an algorithm that attempts to reserve a sane 
amount of memory for a given highly-used data structure in the kernel. By 
using the slab layer to keep memory reserved and ready, performance-critical 
sections of the kernel code (say, code that receives a packet) doesn't have 
to stop and succeed an allocation before continuing.

Cheers,
Chase

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDHNii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUDHNih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:38:37 -0400
Received: from [194.67.69.111] ([194.67.69.111]:31633 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S261763AbUDHNih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:38:37 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200404081338.RAA16267@yakov.inr.ac.ru>
Subject: Re: route cache DoS testing and softirqs
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 8 Apr 2004 17:38:27 +0400 (MSD)
Cc: kuznet@ms2.inr.ac.ru, Robert.Olsson@data.slu.se (Robert Olsson),
       dipankar@in.ibm.com (Dipankar Sarma),
       davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, paulmck@us.ibm.com, akpm@osdl.org
In-Reply-To: <20040401131657.GB18585@dualathlon.random> from "Andrea Arcangeli" at  =?ISO-8859-1?Q?=20=E1?=
	=?ISO-8859-1?Q?=D0=D2?= 01, 2004 03:16:57 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This sounds reasonable. However as a start I was thinking at having
> hardirq run only the softirq they posted actively, and local_bh_enable
> run only the softirq that have been posted by the critical section (not
> from hardirqs happening on top of it).

To all that I remember Ingo insisted that the run from local_bh_enable() 
is necessary for softirqs triggered by hardirqs while softirqs are disabled.
Otherwise he observed random delays and redundant scheduler activity
breaking at least tux fast path.

Alexey

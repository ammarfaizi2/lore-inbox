Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVAUEGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVAUEGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 23:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVAUEGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 23:06:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:26032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262255AbVAUEF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 23:05:56 -0500
Date: Thu, 20 Jan 2005 20:05:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-Id: <20050120200530.4d5871f9.akpm@osdl.org>
In-Reply-To: <20050121035758.GH12076@waste.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
	<20050120160123.14f13ca6.akpm@osdl.org>
	<20050121035758.GH12076@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Here are the symptoms:
> 
>  mm2: corruption of Tux logo at boot, corruption of display at
>  powerdown, lockup and LCD blooming on next warm boot when radeonfb
>  starts. Ben suggested I try some radeonfb options, but none seemed to
>  have any effect.
> 
>  mm1: no observed problems
> 
>  mm2 - above patches: corruption still occurs but no lockup on next
>  warm boot.

So we have multiple bugs?

Next suspects would be:

+cleanup-vc-array-access.patch
+remove-console_macrosh.patch
+merge-vt_struct-into-vc_data.patch



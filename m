Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUCMWKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUCMWKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:10:41 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:4561 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263207AbUCMWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:10:38 -0500
Subject: Re: i386 very early memory detection cleanup patch breaks the build
From: James Bottomley <James.Bottomley@steeleye.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40538091.9050707@zytor.com>
References: <1079198139.2512.19.camel@mulgrave> 
	<40538091.9050707@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 17:10:08 -0500
Message-Id: <1079215809.2513.39.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 16:43, H. Peter Anvin wrote:
> Could you perhaps describe which architecture this is a problem on, and 
> what its entry condition looks like?

This is the Voyager architecture (mach-voyager)

> I removed it because I removed the VISWS dependency, thus making it 
> redundant.  What you seem to be saying is that the dependency should 
> have been on SMP not X86_SMP; if that's the issue then please make it so.
> 
> I think you just needed to apply your own rule to the above statement.

If you mean the dependency should be

	depends X86_SMP || (VOYAGER && SMP)

Then yes, I'm happy with that.

I'm still debugging the boot time failure.  As far as I can tell it
looks like ioremap is failing (this is after paging_init); does this
trigger any associations?

James


James


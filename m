Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFTSCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFTSCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:02:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64419 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263859AbTFTSCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:02:09 -0400
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
From: john stultz <johnstul@us.ibm.com>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030620140136.GD1038@gmx.de>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <20030620140136.GD1038@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1056132551.18636.541.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 11:09:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 07:01, Wiktor Wodecki wrote:
> same here, time is running way too fast. Kernel 2.5.72-mm1, see attached
> config for config. The cpu is a Pentium III (Coppermine) wit speedstep
> enabled.

Speedstep and the lost-ticks compensation code in the TSC time source
are fighting. Booting w/ "clock=pit" will let you work around it, but
I'm working on trying to make it automatically fall back. 

This is being tracked in Bug #827.
http://bugme.osdl.org/show_bug.cgi?id=827

thanks
-john



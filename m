Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTEBXdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 19:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTEBXc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 19:32:59 -0400
Received: from [12.47.58.20] ([12.47.58.20]:48575 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263205AbTEBXc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 19:32:59 -0400
Date: Fri, 2 May 2003 16:41:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>, Andi Kleen <ak@muc.de>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-Id: <20030502164159.4434e5f1.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.55.0305030014130.1304@jester.mews>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	<1051905879.2166.34.camel@spc9.esa.lanl.gov>
	<20030502133405.57207c48.akpm@digeo.com>
	<1051908541.2166.40.camel@spc9.esa.lanl.gov>
	<20030502140508.02d13449.akpm@digeo.com>
	<1051910420.2166.55.camel@spc9.esa.lanl.gov>
	<Pine.LNX.4.55.0305030014130.1304@jester.mews>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 23:45:19.0434 (UTC) FILETIME=[E3B50AA0:01C31104]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Bernstein <mb--lkml@dcs.qmul.ac.uk> wrote:
>
> On May 2 Steven Cole wrote:
> 
> >Here is a snippet from dmesg output for a successful kexec e100 boot:
> 
> Bizarrely I have a nasty crash on modprobing e100 *without* kexec (having
> previously modprobed unix, af_packet and mii) and then trying to modprobe
> serio (which then deadlocks the machine).
> 
> 	http://www.dcs.qmul.ac.uk/~mb/oops/
> 

Andi, it died in the middle of modprobe->apply_alternatives()


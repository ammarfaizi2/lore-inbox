Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTBYISC>; Tue, 25 Feb 2003 03:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTBYISC>; Tue, 25 Feb 2003 03:18:02 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:33979 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267841AbTBYISB>; Tue, 25 Feb 2003 03:18:01 -0500
Message-Id: <200302250828.h1P8S5s04503@owlet.beaverton.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Make diskstats per-cpu using kmalloc_percpu 
In-reply-to: Your message of "Tue, 25 Feb 2003 13:06:54 +0530."
             <20030225073654.GB28052@in.ibm.com> 
Date: Tue, 25 Feb 2003 00:28:05 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This version makes the disk stats on struct gendisk per-cpu.
    I am working on making the per partition stats per-cpu too (struct
    hd_struct).

In general I'm in favor of this.  It seems intuitive to me that counters
of this type should be per-cpu.  But the question is, do we actually
see any gains?  At the very least, are we sure we've not introduced any
degradation?  Has any of your testing so far been measuring performance or
just checking for correctness?

Rick

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJHXva>; Tue, 8 Oct 2002 19:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbSJHXv3>; Tue, 8 Oct 2002 19:51:29 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:47632
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261323AbSJHXv2>; Tue, 8 Oct 2002 19:51:28 -0400
Subject: Re: bug 2 cpus shows as 4 cpus
From: Robert Love <rml@tech9.net>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
References: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 19:57:08 -0400
Message-Id: <1034121428.29468.1876.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 19:39, Jeff Chua wrote:

> I'm running 2.4.20-pre9 on DELL server with Xeon dual processors, but
> /proc/cpuinfo shows not 2, but "4" cpus!
> 
> The bogomips semms to indicate 2 cpus. (3971.48 is about 2GHz x 2).
> 
> Is this problem related to Xeon? I've other SMP boxes with P3, but they
> reports correctly 2 cpus.

Hahaha, dude, you have hyper-threading!  Each of your Xeons has two
logical processors that share most processor resources but implement two
independent pipelines.  So you have four schedulable processors in
total.

Google around for hyper-threading, HT, and SMT.  It is in all P4-class
Xeons and soon all regular P4s.

	Robert Love


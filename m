Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUJYSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUJYSPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUJYSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:13:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:46859 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261232AbUJYSLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:11:41 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
Date: Mon, 25 Oct 2004 21:11:25 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua> <1098715271.10720.37.camel@lade.trondhjem.org>
In-Reply-To: <1098715271.10720.37.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410252111.25684.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 17:41, Trond Myklebust wrote:
> må den 25.10.2004 Klokka 17:02 (+0300) skreiv Denis Vlasenko:
> 
> > I am using NFS root. At shutdown, when I kill
> > all processes with killall5 -9, NFS temporarily
> > misbehaves. I narrowed it down to rpciod feeling
> > bad when signalled with SIGKILL:
> 
> That is a deliberate feature. It is useful when mountpoints hang etc.
> 
> Note however that the patches that convert rpciod to use a workqueue
> (they can be found in the latest -mm kernels) remove this feature.

These?

linux-2.6.8.1-49-rpc_workqueue.patch
linux-2.6.8.1-50-rpc_queue_lock.patch

I will test 'em, thanks!
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTEFEsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTEFEsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:48:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11759 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262361AbTEFEsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:48:13 -0400
Date: Tue, 6 May 2003 10:33:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506050332.GA1301@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1052187119.983.5.camel@rth.ninka.net> <20030506040856.8B3712C36E@lists.samba.org> <20030505.204002.08338116.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505.204002.08338116.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:40:02PM -0700, David S. Miller wrote:
> I think you should BUG() if a module calls kmalloc_percpu() outside
> of mod->init(), this is actually implementable.
> 
> Andrew's example with some module doing kmalloc_percpu() inside
> of fops->open() is just rediculious.

The disk stats are already per-cpu. So, what happens when you offline/online
a disk ? How do you allocate per-cpu memory during that ?

Thanks
Dipankar

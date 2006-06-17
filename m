Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWFQHxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWFQHxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWFQHxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:53:34 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9166 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932491AbWFQHxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:53:33 -0400
Date: Sat, 17 Jun 2006 16:53:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060617165319.458d913a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4493AF5C.4080600@yahoo.com.au>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<p7364j1qx66.fsf@verdi.suse.de>
	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161236.50302.ak@suse.de>
	<44937B16.3050204@yahoo.com.au>
	<20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>
	<4493AF5C.4080600@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 17:29:32 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > As SIGSTOP/KILL patch I posted, the apps shouldn't do unexpected
> > work, I think.
> 
> I don't quite understand you here... the kernel doesn't need to enforce
> anything but a dumb fallback policy where userspace is otherwise capable
> of handling it themselves.

If all things about apps are properly maintained/managed, it is reconfigured
by the user/system admin *before* cpu hotremove.

The case "the kernel have to move the task to other cpu which user doesn't want"
means the application is already broken.

So, I think "stop mis-configurated process" can be one way for handling  such apps.

For example)
After exchanging broken cpu, the application can continue its work with the
same # of cpus.

-Kame


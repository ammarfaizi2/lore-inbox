Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWFSBKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWFSBKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWFSBKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:10:43 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:49844 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932342AbWFSBKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:10:39 -0400
Date: Mon, 19 Jun 2006 10:12:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060619101231.dde6ce9d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060618164654.GA826@openzaurus.ucw.cz>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<20060618164654.GA826@openzaurus.ucw.cz>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 18:46:55 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > When cpu hot remove happens, tasks on the target cpu will be migrated even if
> > no available cpus in tsk->cpus_allowed. (See: move_task_off_dead_cpu().)
> > 
> > Usually, it looks ok (I think not good but may be ok.) But forced migration
> > should be avoided if there is RT task which is designed to run only on
> > specified cpu.
> 
> That would break software suspend, sorry.
> 
> NAK.
> 				Pavel

Okay. 
I didn't noticed that, sorry.

-Kame


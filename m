Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWFPQJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWFPQJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFPQJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:09:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27075 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751477AbWFPQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:09:31 -0400
Date: Fri, 16 Jun 2006 09:09:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: LKML <linux-kernel@vger.kernel.org>, ashok.raj@intel.com
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
In-Reply-To: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0606160908120.14330@schroedinger.engr.sgi.com>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, KAMEZAWA Hiroyuki wrote:

> When cpu hot remove happens, tasks on the target cpu will be migrated even if
> no available cpus in tsk->cpus_allowed. (See: move_task_off_dead_cpu().)

Could we kill the process instead? If a process has been forced to run on 
a certain cpu then it is an error to migrate it to a different one. If a 
system wiil do cpu hot remove then the system needs to be configured in 
such a way as to allow processes to be migrated to other processors.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWFRDnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFRDnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 23:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFRDnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 23:43:15 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:40389 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751076AbWFRDnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 23:43:15 -0400
Date: Sat, 17 Jun 2006 23:36:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 5/16] 2.6.17-rc6 perfmon2 patch for review: new
  sysfs support
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200606172339_MC3-1-C2C6-D2C3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606150907.k5F97YtU008130@frankl.hpl.hp.com>

On Thu, 15 Jun 2006 02:07:34 -0700, Stephane Eranian wrote:

> --- linux-2.6.17-rc6.orig/perfmon/perfmon_sysfs.c     1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/perfmon/perfmon_sysfs.c  2006-06-08 05:36:31.000000000 -0700
 ...
> +struct pfm_controls pfm_controls = {
> +     .sys_group = PFM_GROUP_PERM_ANY,
> +     .task_group = PFM_GROUP_PERM_ANY,
> +     .arg_size_max = PAGE_SIZE,
> +     .smpl_buf_size_max = ~0,
> +};

This means that by default anyone can create monitoring sessions.
It should start out as restrictive as possible; the admin can relax
permissions as needed.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752350AbWKBTXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbWKBTXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbWKBTXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:23:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:29105 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1752350AbWKBTXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:23:37 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,381,1157353200"; 
   d="scan'208"; a="155058353:sNHT317345245"
Subject: Re: 2.6.19-rc1: Slowdown in lmbench's fork
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
References: <1162485897.10806.72.camel@localhost.localdomain>
	 <m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Intel
Date: Thu, 02 Nov 2006 10:34:13 -0800
Message-Id: <1162492453.10806.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 11:33 -0700, Eric W. Biederman wrote:

> 
> My only partial guess is that it might be worth adding the per cpu
> variables my patch adds without any of the corresponding code changes.
> And see if adding variables to the per cpu area is what is causing the
> change.
> 
> The two tests I can see in this line are:
> - to add the percpu vector_irq variable.
> - to increase NR_IRQs.

Increasing the NR_IRQs resulted in the regression.
Adding the percpu vector_irq variable did not cause any changes.  

Tim

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUHJOQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUHJOQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUHJOQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:16:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265305AbUHJOQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:16:46 -0400
Date: Tue, 10 Aug 2004 10:16:29 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040810085746.GB12445@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0408101006580.7711-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Kurt Garloff wrote:

> * Even with selinux=0 and capability loaded, the kernel takes a 
>   few percents in networking benchmarks (measured by HP on ia64); 
>   this is caused by the slowliness of indirect jumps on ia64.

Is this just an ia64 issue?  If so, then perhaps we should look at only
penalising ia64?  Otherwise, loading an LSM module is going to cause
expensive false unlikely() on _every_ LSM hook.


- James
-- 
James Morris
<jmorris@redhat.com>





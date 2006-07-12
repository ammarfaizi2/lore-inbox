Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWGLOwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWGLOwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGLOwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:52:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28333 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750938AbWGLOwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:52:33 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Date: Wed, 12 Jul 2006 16:52:21 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com> <200607121532.05227.ak@suse.de> <m1ac7edgne.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac7edgne.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121652.21920.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So it will correctly handle that sysctl being compiled out, and
> the fallback to using /proc.  The code seems to have been
> doing that since it was added to glibc in 2000.

Using /proc is extremly slow for this. You added significant 
cost to each program startup.

I still think it's a good idea to simulate that sysctl and printk
the others.
 
-Andi

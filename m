Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUEaLwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUEaLwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEaLwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:52:54 -0400
Received: from panda.sul.com.br ([200.219.150.4]:34308 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S264265AbUEaLwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:52:44 -0400
Date: Mon, 31 May 2004 08:50:09 -0300
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulated VM swappiness
Message-ID: <20040531115009.GG2159@cathedrallabs.org>
References: <200405302330.48595.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405302330.48595.kernel@kolivas.org>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

+               .ctl_name       = VM_AUTO_SWAPPINESS,
+               .procname       = "autoswappiness",
+               .data           = &auto_swappiness,
+               .maxlen         = sizeof(auto_swappiness),
+               .mode           = 0644,
+               .proc_handler   = &proc_dointvec_minmax,
+               .strategy       = &sysctl_intvec,
+               .extra1         = &zero,
+               .extra2         = &one_hundred,
+       },
shouldn't be proc_dointvec here? seems minmax isn't needed.

-- 
Aristeu


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVAMLGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVAMLGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVAMLEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:04:44 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:29365 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261583AbVAMLAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:00:30 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Thu, 13 Jan 2005 11:00:19 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <200501130813.42545.andrew@walrond.org> <200501131042.25470.mmazur@kernel.pl>
In-Reply-To: <200501131042.25470.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131100.19500.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 09:42, Mariusz Mazur wrote:
>
> I'm a distribution vendor. If x11 really required having current kernel
> config at compile time to function properly, I'd start sending threats to
> its authors.

Well there is certainly stuff like

 ifdef ARCHX86
  ifndef CONFIG_X86_CMPXCHG
   $(error CONFIG_X86_CMPXCHG needs to be enabled in the kernel)
  endif
 endif

 and

 ifdef CONFIG_AGP
  ifneq (,$(findstring mga,$(DRM_MODULES)))
   CONFIG_DRM_MGA := m
  endif
 endif

in x11, which makes me very nervous about a blank config.h.

Ho hum...

Andrew Walrond

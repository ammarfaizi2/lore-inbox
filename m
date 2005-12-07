Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVLGUCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVLGUCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVLGUCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:02:25 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:50907 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1030338AbVLGUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:02:24 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
Date: Wed, 7 Dec 2005 20:02:16 +0000
User-Agent: KMail/1.8.2
References: <4395F405.9010107@droids-corp.org> <43971BD5.6040601@droids-corp.org> <20051207191030.GA7585@mars.ravnborg.org>
In-Reply-To: <20051207191030.GA7585@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512072002.16084.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 19:10, Sam Ravnborg wrote:
> On Wed, Dec 07, 2005 at 06:28:53PM +0100, Olivier MATZ wrote:
> > But in my opinion, as we use CONFIG_HERTZ in param.h, we should keep the
> > include of config.h.
>
> If you look at the commandline passed to gcc you will notice -include
> include/linux/autoconf.h which tell gcc to pull in autoconf.h.
> So it is no longer required to include config.h.
>

Is it the intention for the real kernel headers to be used by userland apps, 
and for linux-libc-headers et-al to be deprecated?

If so, how far down this road are we? I tested a few things recently, out of 
interest;

- recent glibc builds fine with real 2.6.14.2 headers
- x11 cvs won't build without real kernel headers
- net-tools will only build with sanitized headers

Andrew Walrond

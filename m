Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161597AbWHELKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161597AbWHELKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161596AbWHELKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:10:04 -0400
Received: from canuck.infradead.org ([205.233.218.70]:34995 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161594AbWHELKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:10:02 -0400
Subject: Re: ELF: what should be part of the userspace headers?
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-audit@redhat.com
In-Reply-To: <20060805110559.GU25692@stusta.de>
References: <20060805110559.GU25692@stusta.de>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 19:08:43 +0800
Message-Id: <1154776124.5181.57.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 13:05 +0200, Adrian Bunk wrote:
> include/linux/elf-em.h is used by include/linux/audit.h, but this usage 
> doesn't seem to be part of the kernel <-> userspace interface?

The machine types _are_ part of the audit kernel<->userspace interface,
I think. Exporting elf-em.h should be fairly harmless.

> And which part of the ELF headers is part of the kernel <-> userspace 
> interface?

Almost none of them, I'd suggest. Nothing but auxvec.h

-- 
dwmw2


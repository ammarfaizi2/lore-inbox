Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423299AbWJSLeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423299AbWJSLeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423300AbWJSLeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:34:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3247 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423299AbWJSLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:34:35 -0400
Subject: Re: make headers_install headers problem on sparc64
From: David Woodhouse <dwmw2@infradead.org>
To: andrew@walrond.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061019111037.GD17882@pelagius.h-e-r-e-s-y.com>
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com>
	 <20061019105441.GC17882@pelagius.h-e-r-e-s-y.com>
	 <20061019111037.GD17882@pelagius.h-e-r-e-s-y.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 12:34:32 +0100
Message-Id: <1161257672.3428.3.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 11:10 +0000, andrew@walrond.org wrote:
> Simply copying asm-generic/unaligned.h into the sanitised header tree
> under asm/ solves the problem, so should headers_install just include
> unaligned.h ? 

No. That header should not be exposed to userspace. Just fix
reiserfsprogs instead. It's not as if unaligned access is _hard_ -- you
just have to ask the compiler to do it for you:

http://cvs.fedora.redhat.com/viewcvs/rpms/reiserfs-utils/devel/header-fix.patch?view=markup

-- 
dwmw2


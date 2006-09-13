Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWIMNoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIMNoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIMNoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:44:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750818AbWIMNoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:44:02 -0400
Subject: Re: [PATCH 1/2] Split i386 and x86_64 ptrace.h
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, 76306.1226@compuserve.com,
       ak@muc.de, jeremy@xensource.com, rusty@rustcorp.com.au, zach@vmware.com
In-Reply-To: <200609121552.k8CFq4IE008007@ccure.user-mode-linux.org>
References: <200609121552.k8CFq4IE008007@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 13:57:50 +0100
Message-Id: <1158152271.9189.129.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 11:52 -0400, Jeff Dike wrote:
> The use of SEGMENT_RPL_MASK in the i386 ptrace.h introduced by
> x86-allow-a-kernel-to-not-be-in-ring-0.patch broke the UML build, as
> UML includes the underlying architecture's ptrace.h, but has no easy
> access to the x86 segment definitions.
> 
> Rather than kludging around this, as in the past, this patch splits
> the userspace-usable parts, which are the bits that UML needs, of
> ptrace.h into ptrace-abi.h, which is included back into ptrace.h.
> Thus, there is no net effect on i386.
> 
> As a side-effect, this creates a ptrace header which is close to being
> usable in /usr/include.

Yum. But you didn't add that new header to the Kbuild file so it doesn't
get exported. Please do so.

-- 
dwmw2


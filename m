Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWJCJoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWJCJoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWJCJoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:44:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3217 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964838AbWJCJoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:44:20 -0400
Subject: Re: [PATCH] namespaces: utsname: implement utsname namespaces
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Serge Hallyn <serue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Andrey Savochkin <saw@sw.ru>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1159865871.3438.60.camel@pmac.infradead.org>
References: <200610021601.k92G10p6003499@hera.kernel.org>
	 <1159865871.3438.60.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 10:44:17 +0100
Message-Id: <1159868657.3438.82.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 09:57 +0100, David Woodhouse wrote:
> usr/include/linux/utsname.h requires linux/kref.h, which does not exist in exported headers
> usr/include/linux/utsname.h requires linux/nsproxy.h, which does not exist in exported headers
> usr/include/linux/utsname.h requires asm/atomic.h, which does not exist in exported headers 

We can probably just drop utsname.h from the export, since libc can't
use it as-is anyway. It doesn't actually define 'struct utsname'.

-- 
dwmw2


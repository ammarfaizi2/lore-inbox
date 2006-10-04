Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWJDP52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWJDP52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWJDP52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:57:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161266AbWJDP51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:57:27 -0400
Subject: Re: 2.6.18-mm1: true/false enum in linux/stddef.h fails glibc-2.4
	compile
From: Arjan van de Ven <arjan@infradead.org>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061004155155.GD17660@pool-71-123-69-209.wma.east.verizon.net>
References: <20061004155155.GD17660@pool-71-123-69-209.wma.east.verizon.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 04 Oct 2006 17:57:04 +0200
Message-Id: <1159977424.3000.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 11:51 -0400, Eric Buddington wrote:
> There is an enum contained in some recent -mm versions of
> linux/stddef.h which seems to be horking my glibc-2.4 compile:
> 
> enum {
>         false   = 0,
>         true    = 1
> };
> 
> One way or another (I can't find where), 'true' and 'false' are
> getting defined to 1 and 0, turning the above into enum { 0=0, 1=1 },
> which though undeniable is not compilable.

I think you're making the mistake of using kernel headers for
userspace...... rather than the cleaned up headers.


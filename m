Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVETQ6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVETQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVETQ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:58:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31156 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261506AbVETQ54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:57:56 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 20 May 2005 17:55:43 +0100
Message-Id: <1116608144.29037.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 12:40 -0400, Stephen Smalley wrote:
> Untested patch below, relative to 2.6.12-rc4-mm2 plus your socketcall
> patch to avoid the obvious conflict there.  Is this what you had in
> mind?

Yeah, basically. Although it would be better to introduce AUDIT_AVC_PATH
instead of using AUDIT_AVC for the type. If there's general agreement
this this is a sane answer, I'll stick it in the git tree. Can I see a
Signed-off-by line please?

-- 
dwmw2


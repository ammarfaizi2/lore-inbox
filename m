Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWFHKtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWFHKtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWFHKtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:49:47 -0400
Received: from canuck.infradead.org ([205.233.218.70]:51879 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932231AbWFHKtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:49:46 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <1149726685.23790.8.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
	 <1149656647.27572.128.camel@localhost.localdomain>
	 <20060606222942.43ed6437.akpm@osdl.org>
	 <1149662671.27572.158.camel@localhost.localdomain>
	 <20060607132155.GB14425@elte.hu>
	 <1149726685.23790.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 11:49:28 +0100
Message-Id: <1149763768.13596.140.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 10:31 +1000, Benjamin Herrenschmidt wrote:
> I still don't think where is the suckage in just not hard-enabling in
> the mutex debug code... 

If the mutex debugging code is hard-enabling interrupts before
init_IRQ() ever got called, that's just broken. Fixing that can hardly
be called 'suckage'.

-- 
dwmw2


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWHRMK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWHRMK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWHRMK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:10:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23971 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030303AbWHRMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:10:26 -0400
Subject: Re: [PATCH] [3/3] Support piping into commands in
	/proc/sys/kernel/core_pattern
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1155902485.4494.164.camel@laptopd505.fenrus.org>
References: <20060814127.183332000@suse.de>
	 <20060814112732.684D313BD9@wotan.suse.de>
	 <20060816084354.GF24139@kroah.com> <20060816111801.0fc5093e.ak@muc.de>
	 <20060816111025.1ab702a1.akpm@osdl.org> <20060817094640.GA3173@muc.de>
	 <1155814064.15195.60.camel@localhost.localdomain>
	 <20060817223009.932f9383.akpm@osdl.org>  <20060818082958.GA5862@muc.de>
	 <1155902485.4494.164.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 14:10:01 +0200
Message-Id: <1155903001.4494.166.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 14:01 +0200, Arjan van de Ven wrote:
> On Fri, 2006-08-18 at 10:29 +0200, Andi Kleen wrote:
> > > But still.   Is this code secure?
> > 
> > Any auditing from third parties appreciated.
> > 
> > I don't know of any obvious flaws (at least assuming the pipe handler
> > isn't insecure code), but then I'm biased. 
> 
> one angle is... is the userspace handler trusted code by root? Or is it
> allowed to be per user/user defined binary? In the later case there are
> all kinds of DoS scenarios possible; in the former it's root doing that
> to himself ;)

so one angle that needs to be resolved is the selinux interaction, where
root!=root to some degree. If "any root" can control the sysctl, then
this could lead to information leaks, or worse, to a "limited root" to
"full root" escalation...

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


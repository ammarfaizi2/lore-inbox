Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWF3Ify@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWF3Ify (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWF3Ify
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:35:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41145 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932134AbWF3Ifx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:35:53 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Arjan van de Ven <arjan@infradead.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <a36005b50606292048y2436282cv909a264b4fb7b909@mail.gmail.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <1151568930.3122.0.camel@laptopd505.fenrus.org>
	 <a36005b50606292048y2436282cv909a264b4fb7b909@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 10:35:45 +0200
Message-Id: <1151656545.11434.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 20:48 -0700, Ulrich Drepper wrote:
> On 6/29/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > the thing is.. you can say EXACTLY the same about PROT_EXEC.. not all
> > processors support enforcing that.. so should we just always imply
> > PROT_EXEC as well?
> 
> There is a fundamental difference: not setting PROT_EXEC has no
> negative side effects.  You might be able to execute code and it just
> works.
> 
> With PROT_READ this is not the case, there _are_ side effects which are visible.

there are side effects which are visible with PROT_EXEC too, and even
the same kind...

with PROT_READ you may read even if you didn't specify it
with PROT_EXEC you may execute even if you didn't specifiy it

apps like JVM's forgot PROT_EXEC and break when the hardware enforces it
apps that forget PROT_READ break when the kernel/hardware enforce it

not too much difference....



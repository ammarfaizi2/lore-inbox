Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWF2IPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWF2IPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWF2IPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:15:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63435 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750873AbWF2IPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:15:35 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Arjan van de Ven <arjan@infradead.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 10:15:29 +0200
Message-Id: <1151568930.3122.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 09:43 -0700, Ulrich Drepper wrote:
> On 6/27/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Usability for "normal" C applications is probably not too high... so
> > why not work around it in glibc, if at all?
> 
> Because it wouldn't affect all b inaries.  Existing code could still
> cause the problem.  Also, there are other callers of the syscalls
> (direct, other libcs, etc).  The only reliable way to get rid of this
> problem is to enforce it in the kernel.  Since the kernel cannot make
> sense of this setting in all situations it is IMO even necessary since
> you really don't want to have anything as unstable as this code.

the thing is.. you can say EXACTLY the same about PROT_EXEC.. not all
processors support enforcing that.. so should we just always imply
PROT_EXEC as well?


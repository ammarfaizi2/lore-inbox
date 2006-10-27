Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946218AbWJ0Hjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946218AbWJ0Hjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946220AbWJ0Hjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:39:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:18897 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946218AbWJ0Hje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:39:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 3/13] KVM: kvm data structures
Date: Fri, 27 Oct 2006 09:39:31 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com> <200610270055.45560.arnd@arndb.de> <45419EEC.6010901@qumranet.com>
In-Reply-To: <45419EEC.6010901@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610270939.31988.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 07:53, Avi Kivity wrote:
> > Assuming that you move to the host-user == guest-real memory
> > model, will this data structure still be needed? It would
> > be really nice if a guest could simply consist of a number
> > of vcpu structures that happen to be used from threads in the
> > same process address space, but I find it hard to tell if
> > that is realistic.
> >   
> 
> We'd still need the shadow page table data structures (or the nested 
> page tables pgd).

One hack around this would be to have the shadow page tables hang
off the mm_context_t, automatically allocated when a task first
calls runs kvm. Don't know if that's worthwhile doing, considering
that it's rather ugly.

	Arnd <><

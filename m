Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUGNDPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUGNDPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUGNDPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:15:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61609 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267234AbUGNDPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:15:47 -0400
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
	<m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
	<E1BjmAw-0005MS-00@bigred.inka.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 14 Jul 2004 00:15:43 -0300
In-Reply-To: <E1BjmAw-0005MS-00@bigred.inka.de>
Message-ID: <ork6x7p9cw.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2004, Olaf Titz <olaf@bigred.inka.de> wrote:

> (Worse in C++ where usage of NULL is discouraged, I've always
> wondered about the reasons.)

FWIW, g++ defines NULL to the __null GCC-extension keyword, that
issues a warning if it's doesn't decay to a pointer type, but behaves
like the integral constant of value 0 otherwise, as required by the
C++ standard.

I suppose Linux might benefit from such an extension implemented in C
as well.  Well, looks like sparse already takes care of that, and GCC
has entered an new-extension-avoidance mode (or mood? :-) a few years
ago.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

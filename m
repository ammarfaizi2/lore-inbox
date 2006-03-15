Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCOUjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCOUjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOUjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:39:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53974 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751315AbWCOUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:39:20 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Arjan van de Ven <arjan@infradead.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<1142452665.3021.43.camel@laptopd505.fenrus.org>
	<C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org>
	<m1ek13h3ej.fsf@ebiederm.dsl.xmission.com>
	<006E591F-5F82-4B79-8D1A-581B6AF00185@kernel.crashing.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 13:37:57 -0700
In-Reply-To: <006E591F-5F82-4B79-8D1A-581B6AF00185@kernel.crashing.org> (Kumar
 Gala's message of "Wed, 15 Mar 2006 14:28:42 -0600")
Message-ID: <m1slpjfnq2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@kernel.crashing.org> writes:

> Warnings primarily, however I think some places have assumptions  about size
> that have to be looked at.

Ok.  So nothing too bad just a thorough audit.  Although any driver that
has a real problem with a 64bit type is already broken on every 64bit
arch.

And we do need the 64bit type so we can handle 64bit pci resources on
x86 and ppc32 at some point.

Eric

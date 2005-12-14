Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVLNTYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVLNTYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVLNTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:24:44 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:57729 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964904AbVLNTYn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:24:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K6X290JXjST10hrRpHcH0fIA48B8Kn6FAMWNtOP2kKtVpno43gzXNY3zhVjisBJMwXx/opt7+E7Vu6Vy3F6X1X+cWGeWmrmiV40VgJZgz+3fd82hcZ0V0G7QIaP5eOFN8IrhaJ33hzzH0V99pQTzVl1foyH8E0UROXw5Ei2tF/U=
Message-ID: <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com>
Date: Wed, 14 Dec 2005 12:24:42 -0700
From: Dave <dave.jiang@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64 segfault error codes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73hd9b8r9w.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
	 <p73hd9b8r9w.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah ok, thx! Looks like the comment in mm/fault.c is wrong then.... It
says bit 3 is instruction fetch and no mention of bit 4.

On 14 Dec 2005 19:31:07 +0100, Andi Kleen <ak@suse.de> wrote:
> Dave <dave.jiang@gmail.com> writes:
>
> > For segfault error codes on x86_64, bits 0-3 are documented in
> > arch/x86_64/mm/fault.c. However, I am getting error 0x14 and 0x15 with this
> > particular user app when it segfaults. Is bit 4 valid and what does that
> > imply?
>
> bit 4 is documented too in 2.6. It means it was an instruction fetch.
> The error code is just the architectural error code for page faults
> BTW, see the Intel and AMD manuals for details.
>
> -Andi
>


--
-= Dave =-

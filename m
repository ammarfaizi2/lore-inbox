Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVLNFqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVLNFqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVLNFqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:46:24 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:487 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751377AbVLNFqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:46:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FP/hHldrlXmjmQ/2Fc2GxCd9Hmp2eAWHs6c7xKFFqMsVHCqy/HS5R7VR0zHkygMi2I66scHXRAIoC0zE1Q0zAjfOgcoAXNTCHxqt/Nz6mI2eTMnKDgAQzdXL2Dv1hMsEDLxOT5/T8wNmGMK8KEdvpU/XBj/f4fJml6HKg3q9f/c=
Message-ID: <81083a450512132146g1177b457q5fd6cc5685a3d3b3@mail.gmail.com>
Date: Wed, 14 Dec 2005 11:16:21 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Jesper Juhl <jesper.juhl@gmail.com>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1134525816.30383.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	 <1134525816.30383.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> We already do this to resolve (more) symbols, so I don't see it as a
> problem.  However, I believe that lock is redundant here: we need both
> locks to write the list, but either is sufficient for reading, and we
> already hold the sem.

Was just wondering, in that case, if we really need the spinlock in
resolve_symbol() function, where there exists a spinlock around the
__find_symbol() function

Cheers
Ashutosh

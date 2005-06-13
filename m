Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFMAY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFMAY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 20:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVFMAY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 20:24:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261285AbVFMAYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 20:24:54 -0400
Date: Sun, 12 Jun 2005 17:26:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
Subject: Re: Add pselect, ppoll system calls.
In-Reply-To: <1118616499.9949.103.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
References: <1118444314.4823.81.camel@localhost.localdomain>
 <1118616499.9949.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Jun 2005, Alan Cox wrote:
> 
> If glibc has a race why not just fix glibc ?

.. because glibc tries to implement the "pselect()" interfaces that some 
other OS's implement.

Whether that is a good idea or not (it's not) is a different issue, but 
basically it means that apps don't use the longjmp trick exactly because 
they think pselect() works ok.

		Linus

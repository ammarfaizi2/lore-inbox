Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVFMLSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVFMLSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVFMLSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:18:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5848 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261513AbVFMLSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:18:07 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
In-Reply-To: <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118661326.9949.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 12:15:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 01:26, Linus Torvalds wrote:
> On Sun, 12 Jun 2005, Alan Cox wrote:
> > 
> > If glibc has a race why not just fix glibc ?
> 
> .. because glibc tries to implement the "pselect()" interfaces that some 
> other OS's implement.
> 
> Whether that is a good idea or not (it's not) is a different issue, but 
> basically it means that apps don't use the longjmp trick exactly because 
> they think pselect() works ok.

Right but why can't glibc be fixed to use the longjmp trick internally.
That way pselect works properly for all applications as soon as the
glibc bug fix is
applied and the vendor/distro/whatever pushes a new glibc package ?

Alan


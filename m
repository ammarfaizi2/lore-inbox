Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUBYN1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUBYN1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:27:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261324AbUBYN1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:27:36 -0500
Date: Wed, 25 Feb 2004 08:27:49 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Jean-Luc Cooke <jlcooke@certainkey.com>, <christophe@saout.de>,
       <linux-kernel@vger.kernel.org>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: cryptoapi highmem bug
In-Reply-To: <20040224220030.13160197.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Andrew Morton wrote:

> Jean-Luc Cooke <jlcooke@certainkey.com> wrote:
> >
> > How do I check for equal real addresses from two virtual ones?
> 
> I don't think there is a practical way of doing this.  It would involve
> comparing the virtual address with the kmap and atomic kmap regions,
> performing a pagetable walk, extracting the pageframe.  If the page is not
> in a kmap area generate the pageframe directly.  Make that work on all
> architectures.  Very yuk.
> 
> If practical this API should have been defined in terms of
> (page/offset/len) and it should have kmapped the pages itself.  I guess
> it's too late for that.

Do you mean that the crypt() function should do kmapping?

It's not too late to change internals.



- James
-- 
James Morris
<jmorris@redhat.com>



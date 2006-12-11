Return-Path: <linux-kernel-owner+w=401wt.eu-S933336AbWLKOTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWLKOTN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933575AbWLKOTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:19:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933336AbWLKOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:19:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <457D5E01.7010307@garzik.org> 
References: <457D5E01.7010307@garzik.org>  <457D559C.2030702@garzik.org> <29447.1165840536@redhat.com> <15033.1165842882@redhat.com> 
To: Jeff Garzik <jeff@garzik.org>
Cc: David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Dec 2006 14:18:25 +0000
Message-ID: <17714.1165846705@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:

> > I'm not sure that's a good idea.  You have to be careful not to cause
> > confusion with ordinary "const".
> 
> It's all in the naming.  You could call it 'purefunc' or somesuch.

No, not "pure".  That's something else.

> __attribute__ is very very ugly, an hinders a quick scan of the function
> prototype, particularly if it has a boatload of other attributes.

Maybe you should do:

	extern __attibute__((x, y, z))
	void function_prototype(...);

Then it doesn't hinder it anywhere near as much as, say:

	extern void __fastcall function_prototype(...);

Besides, emacs lights up __attribute__'s in funky colours to make them easier
to look past:-)

David

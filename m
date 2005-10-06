Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVJFRgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVJFRgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJFRgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:36:50 -0400
Received: from pat.uio.no ([129.240.130.16]:31383 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751259AbVJFRgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:36:49 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <1128618447.8396.39.camel@lade.trondhjem.org>
	 <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:36:36 -0400
Message-Id: <1128620196.16534.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.947, required 12,
	autolearn=disabled, AWL 1.05, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 19:23 (+0200) skreiv Miklos Szeredi:
> > No, but what value does an extra function call add then when you already
> > have lookup intents?
> 
> Just to provide a proper interface, and not have to extend open
> intents further.

Why do you consider an extra function call to be a more "proper
interface"?

Does it fix more races? Does it allow you to do new things more
elegantly? Does it offer a better abstraction?

Just trying to understand why you are trying to dump an interface that
has been agreed upon for several years and replace it with one that was
rejected.

> Earlier you said, that intents are meant to be optional, so this
> atomicity requirement is getting further from the "intent" concept.

No it is not. It is bang right in the middle of the intent concept.

Intents are there in order to allow the filesystem to determine which
operation is calling lookup so that it can optimise for that particular
operation.
If your filesystem is able to do lookup+create+open more efficiently
than the VFS can, then that is what it is designed to allow you to do.

Cheers,
  Trond


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDMNAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDMNAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVDMNAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:00:35 -0400
Received: from hermes.domdv.de ([193.102.202.1]:9738 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261332AbVDMNA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:00:29 -0400
Message-ID: <425D17B0.8070109@domdv.de>
Date: Wed, 13 Apr 2005 14:59:28 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> What's wrong with using swap over dmcrypt + initramfs? People have
> already used that to do encrypted swsusp.

Nothing. The problem is the fact that after resume there is then
unencrypted(*) data on disk that should never have been there, e.g.
dm-crypt keys, ssh keys, ...
This may lead to nasty surprises that can occur after weeks or months.

(*) unencrypted from the point of view of the running system.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

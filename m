Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUBXWRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUBXWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:17:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262484AbUBXWQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:16:54 -0500
Date: Tue, 24 Feb 2004 17:17:12 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <20040224202223.GA31232@certainkey.com>
Message-ID: <Xine.LNX.4.44.0402241713220.26251-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Jean-Luc Cooke wrote:

> The two patches are:
>  - http://jlcooke.ca/lkml/ctr_and_omac.patch
>    (added ctr to cipher.c and omac.c)
>    Using the init/update/final interface.
>  - http://jlcooke.ca/lkml/ctr_and_omac2.patch
>    (added ctr to cipher.c and integrated OMAC into all
>    existing modes of operation. If cipher_tfm.cit_omac!=NULL, OMAC is stored
>    into cipher_tfm.cit_omac)

Looks good so far, although the duplicated scatterwalk code needs to be 
put into a separate file (e.g. scatterwalk.c).


> ps. Will crypto_cipher_encrypt/crypto_cipher_decrypt *always* be called in
> onesies?  I need to perform come final() code on the OMAC before it's
> ready to pass test vectors - how do I know when we're done?

I don't understand what you mean here.


Thanks for all this work!


- James
-- 
James Morris
<jmorris@redhat.com>



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUFOXzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUFOXzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUFOXzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:55:37 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:46785 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266022AbUFOXzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:55:36 -0400
Date: Tue, 15 Jun 2004 19:54:09 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Joy Latten <latten@austin.ibm.com>
Subject: Re: RSA
Message-ID: <20040615235409.GA12186@escher.cs.wm.edu>
References: <200406150944.i5F9ixec013290@faith.austin.ibm.com> <Xine.LNX.4.44.0406142127240.25480-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0406142127240.25480-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(repeating a privately posted question for all to respond)

Is a separate generic assymetric crypto API really necessary?

The cryptoapi usage model is to do a setkey before any encrypt or decrypt.
The setkey will be done with either a public or private key.  So there is no
need to have a public_key_alg with separate public_encrypt and
private_encrypt functions, as this distinction is implied at the setkey
time.  So our plan was to just add another crypto_alg for rsa_1024.

If anyone can point out why this is insufficient, then we will certainly
reconsider.

thanks,
-serge

Quoting James Morris (jmorris@redhat.com):
> On Tue, 15 Jun 2004, Joy Latten wrote:
> 
> > Is anyone working on implementing RSA encryption/decryption into the
> > kernel's cryptoapi? If not, I was considering starting such a project.
> 
> Not that I know of.  Would you be looking at this in terms of a generic 
> asymmetric crypto API?
> 
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>

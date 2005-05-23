Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVEWUkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVEWUkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 16:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVEWUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 16:40:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49326 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261953AbVEWUko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 16:40:44 -0400
Date: Mon, 23 May 2005 22:39:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@redhat.com>,
       Toml@us.ibm.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Emilyr@us.ibm.com, Kylene@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050523203929.GA1940@elf.ucw.cz>
References: <Pine.WNT.4.63.0505231351590.4028@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505231351590.4028@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Perhaps I don't understand things fully, but what is the purpose of 
> > > providing measurement values locally via proc?
> > > 
> > > How can they be trusted without the TPM signing an externally generated 
> > > nonce?
> > 
> > If you can't trust what the kernel is outputting in /proc, you're screwed.
> 
> No, this is not the case. You can establish trust into the measurements 
> read through /proc by validating the TPM signature over the measurement 
> aggregate on a separate, trusted system. IMA measurements are not intended 
> to be used on the local system but on a separate system that is trusted not 
> to be compromised. The system validating the measurements does not
> trust 

Actually, you "could" also cat /proc files, then verify the signature
by hand (using pen and paper :-).

It seems to me that the mechanism is sound... it does what the docs
says. Another questions is "is it usefull"?

								Pavel 


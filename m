Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVCBQ62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVCBQ62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVCBQxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:53:55 -0500
Received: from pat.uio.no ([129.240.130.16]:52695 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262378AbVCBQxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:53:20 -0500
Subject: Re: x86_64: 32bit emulation problems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Andi Kleen <ak@muc.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503021233.57341.bernd-schubert@web.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	 <20050302081858.GA7672@muc.de>
	 <1109754818.10407.48.camel@lade.trondhjem.org>
	 <200503021233.57341.bernd-schubert@web.de>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 08:53:07 -0800
Message-Id: <1109782387.9667.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.333, required 12,
	autolearn=disabled, AWL 1.67, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 02.03.2005 Klokka 12:33 (+0100) skreiv Bernd Schubert:

> > I can see no good reason for truncating inode number values on platforms
> > that actually do support 64-bit inode numbers, but I can see several
> 
> Well, at least we would have a reason ;)

A 32-bit emulation mode is clearly a "platform" which does NOT support
64-bit inode numbers, however there is (currently) no way for the kernel
to detect that you are running that. Any extra truncation should
therefore ideally be done by the emulation layer rather than the kernel
itself.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


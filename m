Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWDZDle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWDZDle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWDZDld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:41:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57735 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751638AbWDZDlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:41:32 -0400
Date: Tue, 25 Apr 2006 15:00:13 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Boot <bootc@bootc.net>
Cc: Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, drepper@gmail.com,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Message-ID: <20060425200013.GA7228@sergelap.austin.ibm.com>
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <9C02B13C-8615-440B-A08C-AC463CC2E0AE@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C02B13C-8615-440B-A08C-AC463CC2E0AE@bootc.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Boot (bootc@bootc.net):
> On 25 Apr 2006, at 17:11, Axelle Apvrille wrote:
> 
> >- finally, note you also have choice not to sign this
> >elf loader of yours. If it isn't signed, it won't ever
> >run ;-)
> 
> Wouldn't you need to sign, say, /lib/ld-linux.so?  In that case, you  
> can simply get it to load an execute almost anything that's ELF, even  

It uses dlopen, which does mmap(PROT_EXEC), at which point digsig will
check for a signature.

If you rewrite it to not use mmap(PROT_EXEC), then the signature will
not match.  If you resign it, then you presumably know what you're
doing.

I don't see the problem in this case.

> on filesystems marked noexec, if I'm not mistaken...


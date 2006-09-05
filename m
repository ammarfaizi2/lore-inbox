Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWIEP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWIEP1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWIEP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:27:14 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:63452 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S965076AbWIEP04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:26:56 -0400
Date: Tue, 5 Sep 2006 17:31:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Message-ID: <20060905153159.GA13082@uranus.ravnborg.org>
References: <44FD7FED.7000603@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FD7FED.7000603@sw.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 05:47:25PM +0400, Kirill Korotaev wrote:
> At stage 2 modpost utility is used to check modules.
> In case of unresolved symbols modpost only prints warning.
> 
> IMHO it is a good idea to fail compilation process in case of
> unresolved symbols, since usually such errors are left unnoticed,
> but kernel modules are broken.

The primary reason why we do not fail in this case is that building
external modules often result in unresolved symbols at modpost time.

And there is many legitime uses of external modules that we shall support.

	Sam

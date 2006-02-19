Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWBSMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWBSMqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWBSMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:46:35 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:49904 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S932420AbWBSMqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:46:34 -0500
Date: Sun, 19 Feb 2006 13:45:26 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060219124526.GE862@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <20060218025921.7456e168.akpm@osdl.org> <43F744C6.8020209@pg.gda.pl> <43F7F2FA.2060102@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F7F2FA.2060102@ums.usu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:24:26AM +0500, Alexander E. Patrakov wrote:
> Adam TlaÅ‚ka wrote:
> 
> >Maybe I should remember all bytes of the UTF-sequence to use their 
> >values as a last resort char in case of malformed sequence and 0xfffd
> >not defined?
> 
> Please don't do that. Display question marks instead in the case when 
> 0xfffd is not defined.

But this is the normal console behaviour in case of non existing replacement
glyph for some char. I just not changed it. Anyway if you have no '?' glyph
at '?' char code position you get some different char on the screen.
Replacement glyph should always be defined as I said before,
so this part of code could be easilly removed but I do not really know
if this assumption is true now.

Regards 
-- 
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

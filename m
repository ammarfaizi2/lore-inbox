Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWIHBWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWIHBWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWIHBWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 21:22:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:29143 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752023AbWIHBWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 21:22:04 -0400
Date: Fri, 8 Sep 2006 03:22:01 +0200
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908012201.GA14280@lina.inka.de>
References: <20060907173449.GA24013@clipper.ens.fr> <E1GLPhz-0001T9-00@calista.eckenfels.net> <20060907230028.GB30916@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060907230028.GB30916@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 01:00:28AM +0200, Pavel Machek wrote:
> If attacker already has priviledge foo, he can just go use it. He does
> not have to exec() poor program not expecting to get priviledge foo,
> then abusing it.

It is not about attackers. It is about normal usage. If you spawn a program,
it might behave wrong since it does not know that it is priveledged. For
example a network daemon might start a child process which interacts with
the user, and forgets to drop priveldges for it.

> Sanitized here means "all regular capabilities set, all others
> cleared".

Yes, however I thought this was exactly what the patch is not doing?

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!

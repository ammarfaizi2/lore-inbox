Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269814AbUJMU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269814AbUJMU1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbUJMU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:27:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:10702 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S269814AbUJMU1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:27:07 -0400
Date: Wed, 13 Oct 2004 22:27:05 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Cc: Hirokazu Takata <takata.hirokazu@renesas.com>
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
Message-ID: <20041013202705.GA29258@lina.inka.de>
References: <20041006.151912.840807084.takata.hirokazu@renesas.com> <E1CF6W4-0001hS-00@calista.eckenfels.6bone.ka-ip.net> <20041012.183507.350531171.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041012.183507.350531171.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 06:35:07PM +0900, Hirokazu Takata wrote:
> > > +       do {
> > > +               sio_init();
> > > +       } while ((*status = __sio_in(PLD_ESIO0CR)) != 3);
> 
> Hmm..  Do you have any good idea to fix it?

At least a timeout/maxretry, not sure about the context... is there a locked
blocked? In that case maybe  something like "if !initialized" in all actual
hardware using methods?

Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!

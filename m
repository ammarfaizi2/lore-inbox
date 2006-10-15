Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752315AbWJOBzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbWJOBzs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 21:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWJOBzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 21:55:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752315AbWJOBzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 21:55:47 -0400
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection
	for dvb_attach
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
In-Reply-To: <20061014191441.GU30596@stusta.de>
References: <20061014115356.PS36551000000@infradead.org>
	 <20061014120050.PS78628900008@infradead.org>
	 <20061014121608.GN30596@stusta.de> <45312819.4080909@linuxtv.org>
	 <20061014183322.GS30596@stusta.de> <45313306.104@linuxtv.org>
	 <20061014191441.GU30596@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 14 Oct 2006 22:55:06 -0300
Message-Id: <1160877306.28666.21.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-10-14 às 21:14 +0200, Adrian Bunk escreveu:
> On Sat, Oct 14, 2006 at 02:57:10PM -0400, Michael Krufky wrote:
> > Adrian Bunk wrote:
> > 
> > Two separate problems, please do not confuse them.
> > 
> > My tda10086 and tda826x patches are correct -- there is no question of it.
> 
> The problem is that they don't fix the whole problem.
Yes. Trent made two patches using your suggestion of checking for
MODULE. I'll submit it to Linus probably tomorrow after some tests.

If you want to review, they are at:
http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=b8c06286cb3a;style=gitweb
http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=18a778dbf540;style=gitweb

> To be honest and after looking deeper at it, I don't like this 
> CONFIG_DVB_FE_CUSTOMIZE approach at all since it adds that much 
> complexity for not much gain.
Yes, it adds some complexity. The gain, however, is to allow having
smaller kernel size on embedded systems and DVR using MythTV or Freevo.
There's a similar feature for V4L (Autoselect pertinent
encoders/decoders and other helper chips), that allows selecting just
the needed stuff. 
> 
> I'd simply select all frontends unconditionally
Most users do this, including me :)

Cheers, 
Mauro.


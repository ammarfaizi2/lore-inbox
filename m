Return-Path: <linux-kernel-owner+w=401wt.eu-S1425547AbWLHPRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425547AbWLHPRA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425548AbWLHPRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:17:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50546 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425547AbWLHPRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:17:00 -0500
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] cx88/saa7134: remove unused
	-DHAVE_VIDEO_BUF_DVB
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Krufky <mkrufky@linuxtv.org>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061207172656.GL8963@stusta.de>
References: <20061207150028.GJ8963@stusta.de> <457834E1.1090406@linuxtv.org>
	 <20061207164245.GK8963@stusta.de> <45784BD7.7010605@linuxtv.org>
	 <20061207172656.GL8963@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 08 Dec 2006 13:15:50 -0200
Message-Id: <1165590950.10601.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mkrufky,

Em Qui, 2006-12-07 às 18:26 +0100, Adrian Bunk escreveu:

> No, the configuration
> 
>   CONFIG_VIDEO_SAA7134=y
>   CONFIG_VIDEO_SAA7134_DVB=n
>   CONFIG_VIDEO_BUF_DVB=n
> 
> builds fine in 2.6.19.

> > Thanks, Adrian, for pointing out this inconsistency.

The point here, seemed to be related to the old v4l-dvb building system
and some conflicts with /boot/config. Previously, if /boot/config have a
symbol (for example) CONFIG_VIDEO_BUF_DVB=Y, it would define this symbol
for cx88, saa7134, etc, but it won't compile the required module,
generating some mess. Our current building system were improved in a way
that it will work fine, undefining such symbols.

In other words, just replacing all HAVE_foo to the proper CONFIG_foo
should work fine.

Anyway, I think it is better if you can take a look on it and do some
tests, before cleaning those legacy defines. There's no rush for this to
kernel window, since it would be just a trivial cleanup patch.

Cheers, 
Mauro.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271724AbTG2Oat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTG2Oas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:30:48 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7087
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271724AbTG2Oai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:30:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] O10int for interactivity
Date: Wed, 30 Jul 2003 00:35:01 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu> <3F2682EF.2040702@techsource.com>
In-Reply-To: <3F2682EF.2040702@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307300035.01354.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 00:21, Timothy Miller wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > I'm guessing that the anticipatory scheduler is the culprit here.  Soon
> > as I figure out the incantations to use the deadline scheduler, I'll
> > report back....
>
> It would be unfortunate if AS and the interactivity scheduler were to
> conflict.  Is there a way we can have them talk to each other and have
> AS boost some I/O requests for tasks which are marked as interactive?
>
> It would sacrifice some throughput for the sake of interactivity, which
> is what the interactivity patches do anyhow.  This is a reasonable
> compromise.

That's not as silly as it sounds. In fact it should be dead easy to 
increase/decrease the amount of anticipatory time based on the bonus from 
looking at the code. I dunno how the higher filesystem gods feel about this 
though.

Con


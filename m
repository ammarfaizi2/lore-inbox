Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTHUFTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTHUFTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:19:20 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:3005
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262433AbTHUFTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:19:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@comhem.se>
Subject: Re: [PATCH] O17int
Date: Thu, 21 Aug 2003 15:26:01 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200308200102.04155.kernel@kolivas.org> <20030820162736.GA711@gmx.de> <200308210723.42789.kernel@kolivas.org>
In-Reply-To: <200308210723.42789.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308211526.01796.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unhappy with this latest O16.3-O17int patch I'm withdrawing it, and 
recommending nothing on top of O16.3 yet.

More and more it just seems to be a bandaid to the priority inverting spin on 
waiters, and it does seem to be of detriment to general interacivity. I can 
now reproduce some loss of interactive feel with O17. 

Something specific for the spin on waiters is required that doesn't affect 
general performance. The fact that I can reproduce the same starvation in 
vanilla 2.6.0-test3 but to a lesser extent means this is an intrinsic problem 
that needs a specific solution.

Con


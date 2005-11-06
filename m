Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVKFADJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVKFADJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVKFADI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:03:08 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46829
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932228AbVKFADH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:03:07 -0500
Date: Sat, 05 Nov 2005 16:00:08 -0800 (PST)
Message-Id: <20051105.160008.15802522.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200511041221.jA4CLk78004933@laptop11.inf.utfsm.cl>
References: <davem@davemloft.net>
	<200511041221.jA4CLk78004933@laptop11.inf.utfsm.cl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Fri, 04 Nov 2005 09:21:46 -0300

> Finally found the culprit: SERIAL_SUNZILOG can't be module (or has to be
> loaded early, dunno).

If you want sunzilog to be modular, you have to make sure
the initrd loads it at the beginning of bootup if you want
to have a keyboard.

It's usually best to build it statically, which avoids all
of those complications.

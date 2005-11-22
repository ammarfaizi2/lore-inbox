Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVKVXAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVKVXAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVKVXAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:00:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1970
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030221AbVKVXAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:00:21 -0500
Date: Tue, 22 Nov 2005 15:00:41 -0800 (PST)
Message-Id: <20051122.150041.90521592.davem@davemloft.net>
To: sam@ravnborg.org
Cc: kaber@trash.net, bunk@stusta.de, evil@g-house.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051122224914.GA17575@mars.ravnborg.org>
References: <4381F2D2.5000605@trash.net>
	<20051122.143713.101129339.davem@davemloft.net>
	<20051122224914.GA17575@mars.ravnborg.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Nov 2005 23:49:14 +0100

> On Tue, Nov 22, 2005 at 02:37:13PM -0800, David S. Miller wrote:
> > 
> > One thing we can do to prevent human
> > mistakes, is to make the "make modules" pass do a quick "is vmlinux
> > uptodate?" check, and if not print out an error message explaining the
> > situation and aborting the "make modules" attempt.
> 
> I do not quite follow you here.

If the user tries to do a "make modules" without first rebuilding
their kernel image, then the make will fail if the dependencies
are not satisfied for the main kernel image and it is thus not
up to date.

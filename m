Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbTL3JsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbTL3JsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:48:21 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:48036 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265718AbTL3JsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:48:19 -0500
From: Duncan Sands <baldrick@free.fr>
To: Muli Ben-Yehuda <mulix@mulix.org>, "Sirotkin, Alexander" <demiurg@ti.com>
Subject: Re: network driver that uses skb destructor
Date: Tue, 30 Dec 2003 10:48:06 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, <linux-atm-general@lists.sourceforge.net>
References: <3FF05C27.5030706@ti.com> <20031229172402.GG13481@actcom.co.il>
In-Reply-To: <20031229172402.GG13481@actcom.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312301048.06261.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a patch to allow chaining of skb destructors, which was fairly
> simple and would allow both the driver and the upper layers to set
> their destructors. If there's any interet, I could probably resurrect
> it.

It may also be useful for the ATM layer.  At the moment there is a
vcc->pop routine that frees skb's, it should really be a destructor.
Check out this email:
	http://www.atm.tut.fi/list-archive/linux-atm/msg05485.html
However AFAICS destructors would need to be chained.

Duncan.

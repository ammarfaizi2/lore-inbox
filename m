Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271655AbRICJ2r>; Mon, 3 Sep 2001 05:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271656AbRICJ2i>; Mon, 3 Sep 2001 05:28:38 -0400
Received: from t2.redhat.com ([199.183.24.243]:20210 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271655AbRICJ20>; Mon, 3 Sep 2001 05:28:26 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10109031045530.12103-100000@virtualro.ic.ro> 
In-Reply-To: <Pine.LNX.4.10.10109031045530.12103-100000@virtualro.ic.ro> 
To: Jani Monoses <jani@astechnix.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide_delay_50ms question 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 10:28:42 +0100
Message-ID: <12467.999509322@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jani@astechnix.ro said:
> But then the condition should also extend to CONFIG_BLK_DEV_IDECS_MODUL
> E as well, because when I insert an IDE compactflash card things stop
> for a second or so nad I use a modular driver.

Urgh. Please don't make in-kernel code depend on CONFIG_*_MODULE any more 
than it already does. It's disgusting. 

Why can't we just schedule unconditionally?

--
dwmw2



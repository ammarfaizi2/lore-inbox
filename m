Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbSKSS4g>; Tue, 19 Nov 2002 13:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbSKSS42>; Tue, 19 Nov 2002 13:56:28 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47288 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267290AbSKSSzU>; Tue, 19 Nov 2002 13:55:20 -0500
Subject: Re: [PATCH] mii module broken under new scheme
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <20021119115041.11ece7dc.arashi@arashi.yi.org>
References: <20021119115041.11ece7dc.arashi@arashi.yi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 19:29:53 +0000
Message-Id: <1037734193.12413.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 17:50, Matt Reppert wrote:
> drivers/net/mii.c doesn't export module init/cleanup functions. That means it
> can't be loaded under the new module scheme. This patch adds do-nothing
> functions for it, which allows it to load. (8139too depends on mii, so
> without this I don't have network.)

The bug is in the module layer. This isn't the right fix at all. When
the module layer is fixed to behave sanely the problem will go away


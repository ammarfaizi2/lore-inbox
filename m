Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUCPN06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUCPN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:26:58 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:54159 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S261444AbUCPN04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:26:56 -0500
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client
	isolation
From: Adrian Cox <adrian@humboldt.co.uk>
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4056C805.8090004@convergence.de>
References: <4056C805.8090004@convergence.de>
Content-Type: text/plain
Message-Id: <1079443611.1677.194.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 13:26:52 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 09:25, Michael Hunold wrote:

> What I'd like to have is that client can specify some sort of "class",
> too, and that i2c adapters can tell the core that only clients where the
> class is matching are allowed to probe their existence.

How about a general "never probe" flag combined with a function to
connect an adapter to a client? High level drivers like DVB or BTTV
could then do something like:
	adapter = i2c_bit_add_bus(&my_card_ops);
	i2c_connect_client(adapter, &client_ops, address);

This problem comes up a lot, and i2c probing is only necessary for
finding motherboard sensors. For add-in cards and embedded systems the
driver developer normally knows exactly what is wired to what.

- Adrian Cox
http://www.humboldt.co.uk/



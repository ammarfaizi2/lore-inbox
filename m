Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUIXULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUIXULX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUIXULX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:11:23 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:51615 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S269104AbUIXULV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:11:21 -0400
Subject: Re: suspend/resume support for driver requires an external firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
References: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
Content-Type: text/plain
Message-Id: <1096056665.6925.45.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 22:11:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Current state is the patch makes ipw2100 suspend/resume work in the expense
> of addtional ~200k kernel runtime memory. So I'd rather look on it as a
> workaround instead of a finial solution.

it consumes extra runtime memory, but why not build a simple firmware
cache behind the request_firmware() interface. In this case it can be
transparent for the driver and we won't have an extra workaround for
suspend/resume stuff for every driver. How many firmwares do a normal
system really have to hold in memory for suspend/resume actions?

Regards

Marcel



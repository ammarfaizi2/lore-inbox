Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVLMPQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVLMPQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVLMPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:16:22 -0500
Received: from loon.tech9.net ([69.20.54.92]:39865 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S964974AbVLMPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:16:21 -0500
Subject: Re: tp_smapi conflict with IDE, hdaps
From: Robert Love <rlove@rlove.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>
In-Reply-To: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 10:14:03 -0500
Message-Id: <1134486843.28684.89.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 16:35 +0200, Shem Multinymous wrote:

> Conflict with the "hdaps" module:
> Another function provided by tp_smapi is reporting extended battery
> status, including some data not provided through ACPI. This conflict
> with the recently added HDAPS accelerometer driver. Both drivers read
> their data from the same ports (0x1604-0x161F), which implement a
> query-reponse transaction interface, so both drivers talking to the
> hardware simultaneously will wreak havoc. Some synchronization is
> needed, and a way to address the request_region conflict.

Alan's response is the correct course of action here, but I have a
question: What other data in 0x1604-0x161F is there?

	Robert Love



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265140AbUFVS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUFVS3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUFVS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:28:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:21929 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265140AbUFVSYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:24:46 -0400
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1087928274.1881.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 13:17:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm... your code will not work with externally clocked timebases
(like the G5) and I'm not sure you get the core freq. right with
CPU that can do clock slewing or machines that can switch the
core/bus ratio (laptops).

We should rather define an arch API to return those infos...

Ben.



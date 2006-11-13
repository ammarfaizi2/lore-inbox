Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755183AbWKMQTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbWKMQTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbWKMQTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:19:41 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:31894 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1755183AbWKMQTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:19:40 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Stelian Pop <stelian@popies.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163434455.23444.14.camel@localhost.localdomain>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	 <1163434455.23444.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2006 17:20:26 +0100
Message-Id: <1163434826.2805.2.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 17:14 +0100, Stelian Pop wrote:
> 
> +               input_report_abs(ams_info.idev, ABS_X, x - ams_info.xcalib);
> +               input_report_abs(ams_info.idev, ABS_Y, y - ams_info.ycalib);
> +               input_report_abs(ams_info.idev, ABS_Z, z - ams_info.zcalib); 

Sorry about chiming in so late. When I tried to use this with neverball,
ams_info.xcalib - x (and similar for the others) was more useful because
of the way things are oriented. If I tilt my powerbook to the left then
with this original code the mouse cursor moves to the right which is
contrary to what neverball expects.

Not sure if we want to change this or not, it sort of boils down to a
userspace issue and we could just patch neverball to have a direction
inversion :)

johannes

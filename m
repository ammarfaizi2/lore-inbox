Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTL1ABO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTL1ABO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:01:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:7644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264893AbTL1ABN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:01:13 -0500
Date: Sat, 27 Dec 2003 16:00:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: dtor_core@ameritech.net, gcs@lsc.hu, linux-kernel@vger.kernel.org,
       petero2@telia.com, john stultz <johnstul@us.ibm.com>
Subject: Re: Synaptics problems in -mm1
Message-Id: <20031227160053.11bcd12d.akpm@osdl.org>
In-Reply-To: <20031227183704.GD10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu>
	<200312271228.59192.dtor_core@ameritech.net>
	<20031227181120.GC10491@louise.pinerecords.com>
	<200312271323.22252.dtor_core@ameritech.net>
	<20031227183704.GD10491@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> wrote:
>
>  > I think it ACPI PM timer if you have it activated - I am having problems
>  > with it myself but didn't have time to look closer.  Could you try booting
>  > with clock=tsc or clock=pit and see if it fixes the touchpad.
> 
>  clock=tsc		appears to fix the problem.
>  clock=pit		no change.

So we've established that it is an interaction between the input code, the
ACPI PM time code and cpufreq, yes?  That's a bit of a witches brew.

Does anyone know what aspect of the ACPI PM timer behaviour could cause
this?


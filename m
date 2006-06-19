Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWFSMId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWFSMId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFSMId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:08:33 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6812 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932401AbWFSMIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:08:32 -0400
Date: Mon, 19 Jun 2006 14:08:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
In-Reply-To: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
Message-ID: <Pine.LNX.4.61.0606191407150.31576@yvahk01.tjqt.qr>
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>There's a long-standing issue in init=/bin/sh mode: pressing control-C
>doesn't send a SIGINT to programs running on the console. The incurred
>typical pitfall is if one runs ping without a -c option... no way to
>stop it!

Worse, I can observe same behavior when using "-b", i.e. init=/sbin/init 
called with -b (read: `/sbin/init -b`), and init starts a su shell before 
continuing. No ^C either to my knowledge.
rpm -q sysvinit: 2.86


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbUDTOfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUDTOfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbUDTOfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:35:25 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:37641 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262981AbUDTOfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:35:21 -0400
Message-ID: <1082471690.4085350a565d7@imp.gcu.info>
Date: Tue, 20 Apr 2004 16:34:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors (W83627HF) in Tyan S2882
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> Yes, I had CONFIG_SENSORS_W83781D=y. I have recompiled with
> CONFIG_SENSORS_W83627HF=y and without CONFIG_SENSORS_W83781D, but the
> new kernel still can see only three fans.

I think you need to include the w83627hf driver (for the Winbond
W83627HF chip) and the lm85 driver (for the Analog Devices ADM1027
chip). Don't forget to include the i2c-amd756 and i2c-amd8111 drivers
as well, since the ADM1027 chip has to be connected to either of these
busses.

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


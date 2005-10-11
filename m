Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVJKTk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVJKTk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVJKTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:40:26 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:15845 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932294AbVJKTkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:40:25 -0400
Date: Tue, 11 Oct 2005 21:41:04 +0200
From: DervishD <lkml@dervishd.net>
To: Savar <savar@schuldeigen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "sync" option with usb storage makes it real slow since 2.6.13
Message-ID: <20051011194104.GA130@DervishD>
Mail-Followup-To: Savar <savar@schuldeigen.de>,
	linux-kernel@vger.kernel.org
References: <20051011211603.8aff1cee.savar@schuldeigen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051011211603.8aff1cee.savar@schuldeigen.de>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Savar :)

 * Savar <savar@schuldeigen.de> dixit:
> When I mount an usb stick with the option "sync" (USB 2.0) I got a
> writing speed about 15 kbyte/s. Reading is ok (ca. 1 s for 2,3 MB). 
> It doesn't matter if trying as root or normal user. I only have to
> unmount the stick and remount it without "sync" and writing is fast.
> That means I write something on the stick (ok it's buffered) and 
> then I type "sync" as command and after 1 s it's done (LED from
> usb stick turned off and data were written).

    I had *exactly* the same problem. 2.6.13 honors the "sync" mount
option for VFAT, that's the reason.

    Even if your device has wear leveling built in, you better not
use "sync" on a flash device. If you search the mailing list archives
(try searching for my nick "DervishD" and "usb-storage") you can see
that this issue was discussed before. I think it was a month ago,
maybe a bit more.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...

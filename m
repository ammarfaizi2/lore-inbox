Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267674AbUHJS5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267674AbUHJS5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUHJSzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:55:49 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:40331 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267608AbUHJSrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:47:12 -0400
Date: Tue, 10 Aug 2004 19:46:48 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: "Luesley, William" <william.luesley@amsjv.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Network routing issue
In-Reply-To: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD0@nmex02.nm.dsx.bae.co.uk>
Message-ID: <Pine.LNX.4.60.0408101944200.2622@fogarty.jakma.org>
References: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD0@nmex02.nm.dsx.bae.co.uk>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Luesley, William wrote:

> In order to help testing, I have been asked to place a third machine between
> these two which will be capable of intercepting and modifying any messages.

> My initial plan was to have a device which could mimic both ends of the
> connection (as I already have code to do this); with each connection being
> on a separate NIC, leading to a setup as shown below:
>
>          A ------------ C  C  ---------- B
> 192.168.1.1    192.168.1.2  192.168.1.1   192.168.1.2
>                    (eth0)  (eth1)

> Can I use IP Tables, how?
>
> Or, am I on totally the wrong track?

You're on the wrong track. C doesnt even need IP addresses, two 
choices:

- C as bridge and use ebtables (C doesnt even need addresses 
theoretically)

- C as router, use iptables. C needs one or more addresses which must 
be different.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Violence is a sword that has no handle -- you have to hold the blade.

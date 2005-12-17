Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVLQCzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVLQCzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 21:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLQCzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 21:55:40 -0500
Received: from xenotime.net ([66.160.160.81]:10430 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751360AbVLQCzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 21:55:39 -0500
Date: Fri, 16 Dec 2005 18:56:11 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: kernel coder <lhrkernelcoder@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ENDEC port and MII interface
Message-Id: <20051216185611.09544658.rdunlap@xenotime.net>
In-Reply-To: <f69849430512132327h74949755sa1d646bb0d4ad5b5@mail.gmail.com>
References: <f69849430512132327h74949755sa1d646bb0d4ad5b5@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005 23:27:05 -0800 kernel coder wrote:

> hi,
>     I'm trying to write ethernet driver.I need some explaination on
> ENDEC port and MII interface.By googling i've come to know that MII is
> used for phy communication by modern ethernet cards,but i haven't
> found much info on  ENDEC ports.
> 
> Actually mine card has option to select ENDEC port or MII interface
> for transmit and recieve.
> 
> Please tell me  which one should i choose and why.

A little googling tells me that ENDECs are probably limited to
10 Mbps ethernet.  E.g., one ethernet controller spec says:

     Flexible IEEE 802.3 MII (10/100Mbps) and ENDEC 
    (10Mbps) Interfaces Allow Selection of PHY

ENDECs just convert from 8bit data to 10bit data on Transmit
(8b/10b) and from 10bit data to 8bit data on Receive.
Is ENDEC vs. MII selection a software config on your adapter
or a hardware config?

---
~Randy

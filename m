Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDQMjF>; Tue, 17 Apr 2001 08:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRDQMi6>; Tue, 17 Apr 2001 08:38:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132580AbRDQMin>; Tue, 17 Apr 2001 08:38:43 -0400
Subject: Re: change_mtu boundary checking error
To: shmulik.hen@intel.com (Hen, Shmulik)
Date: Tue, 17 Apr 2001 13:40:34 +0100 (BST)
Cc: linux-net@vger.kernel.org ('LNML'), linux-kernel@vger.kernel.org ('LKML')
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B271DB@hasmsx52.iil.intel.com> from "Hen, Shmulik" at Apr 17, 2001 05:29:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pUmc-0002GY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, the high boundary seemed reasonable (ETH_FRAME_LEN - ETH_HLEN =
> ETH_DATA_LEN) which gives 1500, but why is the low boundary set to 68 ?
> According to my calculations, it should have been ETH_ZLEN - ETH_HLEN which
> gives 46.

The IPv4 minimum MTU is 68 bytes. Below that not all frames can be delivered


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278302AbRJSEZr>; Fri, 19 Oct 2001 00:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278304AbRJSEZh>; Fri, 19 Oct 2001 00:25:37 -0400
Received: from toad.com ([140.174.2.1]:12552 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278302AbRJSEZZ>;
	Fri, 19 Oct 2001 00:25:25 -0400
Message-ID: <3BCFAB6F.15D345B7@mandrakesoft.com>
Date: Fri, 19 Oct 2001 00:26:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Val Henson <val@nmt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Yellowfin bug fix for Symbios cards
In-Reply-To: <20011018210416.D17208@boardwalk> <3BCF9FDD.D6586538@mandrakesoft.com> <20011018215429.A18593@boardwalk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson wrote:
> Hm, good point.  I should figure out why read_eeprom isn't working and
> fix that instead.  Maybe the driver should be changed to attempt to
> read the MAC from the eeprom and then read from the registers if that
> fails, instead of relying on flags.

Yeah.  There is at least one other driver (pcnet32?) that does something
like this...

probe:
	dev->dev_addr[] = read_eeprom();
	if (!is_valid_ether_addr(dev->dev_addr))
		{ read from card registers }

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

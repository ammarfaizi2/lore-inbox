Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278277AbRJSDgX>; Thu, 18 Oct 2001 23:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278287AbRJSDgO>; Thu, 18 Oct 2001 23:36:14 -0400
Received: from toad.com ([140.174.2.1]:19986 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278277AbRJSDgD>;
	Thu, 18 Oct 2001 23:36:03 -0400
Message-ID: <3BCF9FDD.D6586538@mandrakesoft.com>
Date: Thu, 18 Oct 2001 23:37:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Val Henson <val@nmt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Yellowfin bug fix for Symbios cards
In-Reply-To: <20011018210416.D17208@boardwalk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson wrote:
> Long version: Reading the MAC address from the EEPROM didn't work on
> the Symbios card, so I turned on the IsGigabit flag to read it
> correctly.  This also forces full-duplex on, which is wrong.  So I
> added a flag controlling only the MAC address reading behavior and
> turned off the IsGigabit flag for Symbios cards.

Thanks, applied.

Any idea where the MAC address comes from on the Symbios card?

Standard net driver policy is to read the MAC address from the original
source at probe time, typically EEPROM but sometimes in a boot PROM,
firmware console memory, or cardbus CIS.  It is generally preferred to
-not- read the MAC address from the card registers unless you absolutely
have to, since card's copy of the MAC address is easily changeable or
corrupted by rebooting from Windows into Linux or similar things (MacOS
into Linux).

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

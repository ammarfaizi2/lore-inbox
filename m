Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbTCKBDb>; Mon, 10 Mar 2003 20:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbTCKBDb>; Mon, 10 Mar 2003 20:03:31 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:51074 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262782AbTCKBD3>;
	Mon, 10 Mar 2003 20:03:29 -0500
Date: Mon, 10 Mar 2003 20:17:19 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@miee.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310201719.GA10035@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@miee.ru>, linux-kernel@vger.kernel.org
References: <20030310000705.GD2118@neo.rr.com> <Pine.BSF.4.05.10303110205530.63523-100000@wildrose.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.05.10303110205530.63523-100000@wildrose.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 02:15:11AM +0300, Ruslan U. Zakirov wrote:
> Hello, Adam and other.
> Now with this changes, driver depend on CONFIG_PNP.
> What to do if I want compile kernel without PnP layer and I want use my
> soundcard?
> 	Best regards, Ruslan.

Hi Ruslan,

I understand your concern, actually the code that prevents users from using
als100 without CONFIG_PNP is hidden in kconfig.

config SND_ALS100
	tristate "Avance Logic ALS100/ALS120"
	depends on SND && ISAPNP
	help
	  Say 'Y' or 'M' to include support for Avance Logic ALS100, ALS110,
	  ALS120 and ALS200 soundcards.

--->Notice ISAPNP

Also the pnp functions are declared as blank inline functions if CONFIG_PNP
isn't set (see pnp.h).  This will prevent compile errors.  When ALSA drivers
contain support for both pnp and nonpnp devices (such as sb16), CONFIG_PNP
will be used directly in the code.

Best regards to you as well.

Thanks,
Adam

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbRD3Shk>; Mon, 30 Apr 2001 14:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135532AbRD3Shc>; Mon, 30 Apr 2001 14:37:32 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18660 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135513AbRD3ShZ>;
	Mon, 30 Apr 2001 14:37:25 -0400
Message-ID: <3AEDB0D4.2CB47196@mandrakesoft.com>
Date: Mon, 30 Apr 2001 14:37:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Gouget <fgouget@free.fr>
Cc: Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
In-Reply-To: <Pine.LNX.4.21.0104301011380.17715-100000@amboise.dolphin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Gouget wrote:
> CONFIG_PCMCIA=y
> CONFIG_CARDBUS=y
> CONFIG_I82365=y

Not correct -- you do not need I82365 if you have CardBus.  However, if
you are running 2.4.4 you should be ok.

Linux 2.4.4 includes a patch from me that fixes such configurations so
that they don't conflict anymore, but running 2.4.3 or previous with
such a configuration, you are likely to run into a partially-useable
system (pcmcia but not cardbus cards work) or a completely unusable
hotplug system (no cards work).

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |

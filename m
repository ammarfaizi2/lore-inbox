Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271900AbRIIIDI>; Sun, 9 Sep 2001 04:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271901AbRIIICt>; Sun, 9 Sep 2001 04:02:49 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:61073 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271900AbRIIICi>; Sun, 9 Sep 2001 04:02:38 -0400
Date: Sun, 9 Sep 2001 04:02:53 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: <acme@conectiva.com.br>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: IPX and PCMCIA
In-Reply-To: <1000003893.3b9ad93530d5e@www.conectiva.com.br>
Message-ID: <Pine.GSO.4.33.0109090358350.1190-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2001 acme@conectiva.com.br wrote:
>I´m now away from my base, so I´ll only have time to work on this late next
>week, but I´ll analyse this and try to see if I can come up with a fix,
>thanks for the report. Oh, if somebody comes up with a fix in the meantime,
>that would be great 8)

That's fine.  It's a very isolated thing (me enabling IPX.)  I'm guessing
it's a simple oversight in handling the deletion of an interface.  I'll
have to look at the way IP traffic is handled to see if it's just IPX not
MOD_INC_USE_COUNT'ing the driver or something like that.

The obvious fix is to shutdown IPX before removing the card :-)  Another
route would be to have the name remain in existance until the interface
is no longer busy.  Otherwise, the services busying the device cannot be
easily shutdown.

--Ricky



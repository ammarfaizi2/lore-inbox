Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRHFHVf>; Mon, 6 Aug 2001 03:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRHFHVY>; Mon, 6 Aug 2001 03:21:24 -0400
Received: from nathan.polyware.nl ([193.67.144.241]:54288 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S267184AbRHFHVF>; Mon, 6 Aug 2001 03:21:05 -0400
Date: Mon, 6 Aug 2001 09:21:02 +0200
From: Pauline Middelink <middelink@polyware.nl>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, middelink@polyware.nl,
        Alan Cox <alan@redhat.com>
Subject: Re: drivers/media/video/videodev.c uses init_zoran_cards.  2.4.8-pre4
Message-ID: <20010806092102.A29597@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	middelink@polyware.nl, Alan Cox <alan@redhat.com>
In-Reply-To: <386.997073272@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <386.997073272@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Aug 06, 2001 at 02:47:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Aug 2001 around 14:47:52 +1000, Keith Owens wrote:
> drivers/media/video/videodev.c calls init_zoran_cards but that symbol
> does not exist in 2.4.8-pre4.  It looks like a hangover from the rework
> of the zoran drivers.

Ah, gotcha. You have been fooled by the naming stuff. My driver is
for the zr36120, and is based on module_init(),module_exit().

There is also a BUZ zoran (zr36057/60) driver around which happens
to use the generic zoran.c name. (This driver is not made by me...)
That driver is indeed upgraded and it seems uses module_init(),
module_exit() too. So it seems the videodev.c lines can be removed.

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink

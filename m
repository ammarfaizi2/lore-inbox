Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263029AbTCTWjK>; Thu, 20 Mar 2003 17:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbTCTWiS>; Thu, 20 Mar 2003 17:38:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48901 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262722AbTCTWgq>;
	Thu, 20 Mar 2003 17:36:46 -0500
Date: Thu, 20 Mar 2003 14:47:58 -0800
From: Greg KH <greg@kroah.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t and major/minor split
Message-ID: <20030320224757.GC5156@kroah.com>
References: <b5dckh$lv1$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5dckh$lv1$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:42:41PM -0800, H. Peter Anvin wrote:
> 
> a) We use a 32+32 bit split for dev_t.  Major zero, minor < 65536
>    would be reserved for compatibility with the old 16-bit dev_t; it
>    still leaves the zero value the "no device" entry.  We could still
>    use major 0, minor >= 65536 as anonymous devices, or we could
>    switch using major 255 which has been reserved for expansion for
>    the past eight years.

Well, it seems that this is the most reasonable split, able to handle
everyone for a long time.  I can live with it, if only to keep people
from Oracle quiet :)

thanks,

greg k-h

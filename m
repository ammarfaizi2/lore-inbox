Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbTCWITi>; Sun, 23 Mar 2003 03:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262965AbTCWITi>; Sun, 23 Mar 2003 03:19:38 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:17164 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262964AbTCWITi>; Sun, 23 Mar 2003 03:19:38 -0500
Date: Sun, 23 Mar 2003 08:30:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030323083034.A6732@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com> <Pine.LNX.4.44.0303210936590.5042-100000@serv> <20030322013800.GD18835@kroah.com> <Pine.LNX.4.44.0303221306350.5042-100000@serv> <20030323081956.GK26145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030323081956.GK26145@kroah.com>; from greg@kroah.com on Sun, Mar 23, 2003 at 12:19:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 12:19:56AM -0800, Greg KH wrote:
> Look at drivers/usb/core/file.c::usb_open(), it does much the same
> thing.  Well, functionally the same, not identical in any way :)

And sound (well, not actually ranges), input, v4l, tty, etc..
->i_cdev together with char device probes would have solved that nicely
and without the linear list serach in ->open that we got now, which will
bite us much more once 32bit dev_ts are actually used.


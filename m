Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSBENMn>; Tue, 5 Feb 2002 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289495AbSBENMX>; Tue, 5 Feb 2002 08:12:23 -0500
Received: from ns.suse.de ([213.95.15.193]:23820 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289484AbSBENMS>;
	Tue, 5 Feb 2002 08:12:18 -0500
Date: Tue, 5 Feb 2002 14:12:12 +0100
From: Dave Jones <davej@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, Jens Axboe <axboe@suse.de>,
        Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Re: 2.4.17 Oops when trying to mount ATAPI CDROM
Message-ID: <20020205141212.B24679@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andre Hedrick <andre@linuxdiskcert.org>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Jens Axboe <axboe@suse.de>, Manuel McLure <manuel@mclure.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.44.0202050759060.2739-100000@netfinity.realnet.co.sz> <Pine.LNX.4.10.10202042222340.30858-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202042222340.30858-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Mon, Feb 04, 2002 at 10:27:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 10:27:42PM -0800, Andre Hedrick wrote:
 > 
 > Folks there is a bigger problem if we are able to get to loading a
 > sub-driver and we do not have a valid copy of the identify page attached
 > to the drive struct.  The resulting patch below is a nice bounds check for
 > presense of "struct hd_driveid *id = drive->id" but this should have
 > bombed out long before hand.  I do not know if the suspend to swap has
 > altered the behavor or not, but the driver has lost it knowledge about the
 > device attached.

 Suspend to swap hasn't been merged yet, so you shouldn't need
 to worry about this..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

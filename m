Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDORCr>; Mon, 15 Apr 2002 13:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDORCq>; Mon, 15 Apr 2002 13:02:46 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:42252 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312982AbSDORCp>;
	Mon, 15 Apr 2002 13:02:45 -0400
Date: Mon, 15 Apr 2002 09:02:15 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, mdharm@one-eyed-alien.net
Subject: Re: IDE / SmartMedia
Message-ID: <20020415160215.GC21707@kroah.com>
In-Reply-To: <UTC200204151014.KAA639446.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Mar 2002 13:44:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 10:14:14AM +0000, Andries.Brouwer@cwi.nl wrote:
> 	From axboe@brick.kernel.dk Mon Apr 15 10:05:40 2002
> 
> 	-			drive->using_tcq = 1;
> 
> That helps, I think.
> 
> The first boot after deleting this line again crashed,
> but this time with BUG() in <linux/usb.h>.
> All usb stuff was compiled in except for usb-storage,
> which was a module and not loaded.
> 
> Maybe a race somewhere. The second boot all was fine.

If the BUG() call in usb.h happens again, could you please send the
ksymoops trace, and let us know which USB drivers you have loaded?  This
BUG() call (if it's the one I think it is) was added to try to find
buggy drivers.

thanks,

greg k-h

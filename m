Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRJTX3u>; Sat, 20 Oct 2001 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275003AbRJTX3k>; Sat, 20 Oct 2001 19:29:40 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:24332 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274990AbRJTX3Z>;
	Sat, 20 Oct 2001 19:29:25 -0400
Date: Sat, 20 Oct 2001 16:20:21 -0700
From: Greg KH <greg@kroah.com>
To: "Aaron D. Turner" <aturner@whiskey.synfin.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5 breaks usb-storage ?
Message-ID: <20011020162021.A4814@kroah.com>
In-Reply-To: <20011020125945.B4314@kroah.com> <Pine.LNX.4.33.0110201546080.1235-200000@whiskey.synfin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110201546080.1235-200000@whiskey.synfin.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2001 at 03:51:06PM -0700, Aaron D. Turner wrote:
> 
> On Sat, 20 Oct 2001, Greg KH wrote:
> 
> > If you use usb-uhci.o instead of uhci.o on 2.4.13-pre5, does that work?
> > 
> > The uhci.o driver has changed between -pre3 and -pre5, not usb-storage.
> 
> Well looks like I spoke too soon.  Works great on the IBM 600X, but USB is 
> completely hosed under 2.4.13pre5 on my Athalon system.  Can't get the 
> mouse to work, or the pendrive.  I'm getting Oops's during boot in various 
> places (seems to be dependant on what USB things are compiled statically 
> vs. modules).  One such oops is included in the attached dmesg.
> 
> I haven't tried 2.4.13p3 on the Athalon, this was a direct upgrade from 
> 2.4.10.

Bleah, this is the hub.c bug.  This problem is fixed in the -ac tree.
I'd recommend using that tree for now, or just grab the
drivers/usb/hub.c and drivers/usb/hub.h files from a -ac tree and put
them in your 2.4.13-pre5 directory.

If you still have problems after doing that, please let me know.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRJTUJP>; Sat, 20 Oct 2001 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJTUJF>; Sat, 20 Oct 2001 16:09:05 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:3340 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274255AbRJTUIu>;
	Sat, 20 Oct 2001 16:08:50 -0400
Date: Sat, 20 Oct 2001 12:59:45 -0700
From: Greg KH <greg@kroah.com>
To: "Aaron D. Turner" <aturner@whiskey.synfin.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5 breaks usb-storage ?
Message-ID: <20011020125945.B4314@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0110201149570.3045-100000@whiskey.synfin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110201149570.3045-100000@whiskey.synfin.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2001 at 11:50:21AM -0700, Aaron D. Turner wrote:
> 
> 
> I've been playing with a USB pendrive.  Worked great under 2.4.13pre3, but
> now under pre5, the system will not recognize it and not autoload
> usb-storage.  Also, if the input event module (evdev) is loaded, and you 
> manually load usb-storage, it hangs your terminal.  After a while I get 
> the error:
> 
> Oct 19 18:06:32 whiskey kernel: uhci.c: uhci_transfer_result: called for 
> URB c1c69b60 not in flight?
> 
> This is happening on two different systems, an IBM 600X and Athalon based 
> system (both using the uhci driver).
> 
> Once I go back to 2.4.13pre3, the problem goes away...

If you use usb-uhci.o instead of uhci.o on 2.4.13-pre5, does that work?

The uhci.o driver has changed between -pre3 and -pre5, not usb-storage.

thanks,

greg k-h

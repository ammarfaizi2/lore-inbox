Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRJPR3j>; Tue, 16 Oct 2001 13:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJPR33>; Tue, 16 Oct 2001 13:29:29 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:34064 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276424AbRJPR3Q>;
	Tue, 16 Oct 2001 13:29:16 -0400
Date: Tue, 16 Oct 2001 10:20:58 -0700
From: Greg KH <greg@kroah.com>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which USB hsot controller to use?
Message-ID: <20011016102058.H11500@kroah.com>
In-Reply-To: <20011003090455.C22631@kroah.com> <Pine.LNX.4.33.0110151806230.7302-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110151806230.7302-100000@sol.compendium-tech.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 06:08:09PM -0700, Dr. Kelsey Hudson wrote:
> I noticed in the kernel configuration that there are two UHCI drivers for
> UHCI-based motherboards/add-in option boards. Which one is better?

Depends on the drivers/devices you are using.  Currently the uhci.o
driver doesn't work properly for some devices that use bulk queuing
(visor, empeg, bluetooth, etc.) while the usb-uhci driver does.
On the other hand, the usb-uhci driver doesn't work for some people with
other kinds of hardware.

Try both out, and see which one works for you :)

(hopefully this problem goes away soon...)

thanks,

greg k-h

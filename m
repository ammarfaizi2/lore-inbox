Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSJYWZc>; Fri, 25 Oct 2002 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJYWVp>; Fri, 25 Oct 2002 18:21:45 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52228 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261662AbSJYWQy>;
	Fri, 25 Oct 2002 18:16:54 -0400
Date: Fri, 25 Oct 2002 15:21:18 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB scanner (2.5.4x) Fail to access minor
Message-ID: <20021025222118.GA31634@kroah.com>
References: <8c1.3db9c10b.90442@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1.3db9c10b.90442@trespassersw.daria.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 10:09:15PM +0000, Jonathan Hudson wrote:
> 
> The probing finds the minor 48, but the USB_SCN_MINOR() macro in open
> results in the minor transposed to 0. This obviously causes the 
> !p_scn_table[scn_minor] test to fail, dmesg follows:
> (/dev/usbscanner0 is 180,48)

A bit better patch was posted to linux-usb-devel a week or so ago.  It
hasn't been applied as there is some other work going on in this area to
clean up a lot of common code, but until then, you should grab it.

thanks,

greg k-h

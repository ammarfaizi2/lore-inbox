Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSG2RfN>; Mon, 29 Jul 2002 13:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSG2RfN>; Mon, 29 Jul 2002 13:35:13 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:55314 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317538AbSG2RfM>;
	Mon, 29 Jul 2002 13:35:12 -0400
Date: Mon, 29 Jul 2002 10:37:24 -0700
From: Greg KH <greg@kroah.com>
To: Peter <pk@q-leap.com>
Cc: linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: Re: oops with usb-serial converter
Message-ID: <20020729173724.GA10153@kroah.com>
References: <S.0001006613@wolnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S.0001006613@wolnet.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 01 Jul 2002 16:28:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 03:50:46PM +0200, Peter wrote:
> Hello,
> 
> the attached kernel oops happens repeatable
> 
> Hardware:
>   Dell Inspiron 2600 Laptop
>   USB-Serial Converter: UC-232A
> 
> Software:
>   minicom (V1.82.1)
>   kernel: 2.4.19-rc3
>           2.4.19-rc3-ac3

Can you see if the 2.5.29 kernel fixes this problem?  The usb-serial
close() call has been modified to hopefully prevent this from happening
in the 2.5 tree.

And can you also send the output of /proc/bus/usb/devices with your
device plugged in?  There are a lot of different devices that work with
this driver, and I'd like to try to keep track of those that have
problems.

thanks,

greg k-h

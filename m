Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267832AbTAHSI1>; Wed, 8 Jan 2003 13:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTAHSI1>; Wed, 8 Jan 2003 13:08:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5899 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267832AbTAHSI0>;
	Wed, 8 Jan 2003 13:08:26 -0500
Date: Wed, 8 Jan 2003 10:16:45 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC
Message-ID: <20030108181645.GC3127@kroah.com>
References: <20030108165130.GA1181@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108165130.GA1181@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 11:51:30AM -0500, Murray J. Root wrote:
> devfs=mount in lilo.conf
>               
> Insert CF card. 
> ls /dev shows sda and sda1
> mount it. 
> ls /dev shows sda - no sda1
> cd to mounted CF card
> process hangs, sd-mod & usb-storage "busy"
> rmmod -f usb-storage or sd-mod causes PC to stop
> (keyboard & mouse unresponsive, wmfire frozen, net disconnects)
> 
> reboot
> Insert CF card. 
> ls /dev shows sda & sda1
> mount it. 
> ls /dev shows sda - no sda1
> umount it
> ls /dev shows sda - no sda1
> modprobe -r sd-mod && modprobe sd-mod 
> ls /dev shows sda & sda1

So if devfs is enabled, everything works just fine?

thanks,

greg k-h

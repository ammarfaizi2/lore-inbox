Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSBEFz6>; Tue, 5 Feb 2002 00:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBEFzs>; Tue, 5 Feb 2002 00:55:48 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:32772 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288342AbSBEFz2>;
	Tue, 5 Feb 2002 00:55:28 -0500
Date: Mon, 4 Feb 2002 21:53:09 -0800
From: Greg KH <greg@kroah.com>
To: Clifford Kite <ckite@ev1.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel zombie threads after module removal.
Message-ID: <20020205055309.GH31025@kroah.com>
In-Reply-To: <Pine.LNX.4.21.0202042005220.12873-200000@corncob.localhost.tld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202042005220.12873-200000@corncob.localhost.tld>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 08 Jan 2002 02:46:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 08:51:40PM -0600, Clifford Kite wrote:
> This problem occurs in the kernels 2.4.5-ac9 and 2.4.12, with basic USB
> support compiled into both the kernels.  After removing the usb-storage.o
> and the SCSI sd_mod.o modules two zombie kernel treads remain:
> 
> root  2985  0.0  0.0  0  0  ?  Z  12:07  0:00 [usb-storage-0 <defunct>]
> root  2986  0.0  0.0  0  0  ?  Z  12:07  0:00 [scsi_eh_0 <defunct>]

These are usb-storage zombies, and I think the latest 2.4.18-pre tree
has a fix for them.  If not, please contact the usb-storage maintainer,
as he would be the proper person for this.

thanks,

greg k-h

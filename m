Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWETVgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWETVgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWETVgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:36:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:35095 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932344AbWETVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:36:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UjlL8mkf4FH4hEHkzhO3JzF2XG4ngq18OMhl2dbBpHsojJKBo1Ebg/DlK68DOd+zyDj/TpGA8KLAdoYld9dBgq+2Wjj+IeZF86ynQXCbwbz56Vc8BHavyLOzssTKpoyMEwdjCvPr2dKcpz0Xgle8GAs5LPosaYZpI6ZqRqyrC9g=
Date: Sun, 21 May 2006 01:35:06 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pktcdvd major contradicts <linux/Documentation/devices.txt>
Message-ID: <20060520213506.GC7930@mipter.zuzino.mipt.ru>
References: <200605202117.k4KLHT4s007395@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605202117.k4KLHT4s007395@wildsau.enemy.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 11:17:29PM +0200, Herbert Rosmanith wrote:
> (1)
> # grep -B 1 pktcdvd /usr/src/linux/Documentation/devices.txt 
>  97 block       Packet writing for CD/DVD devices
>                   0 = /dev/pktcdvd0     First packet-writing module
>                   1 = /dev/pktcdvd1     Second packet-writing module
> 
> but:
> 
> (2)
> # modprobe pktcdvd
> # grep pktcdvd /proc/devices 
> 254 pktcdvd
> 
> 
> so, in contrast to the documentation, pktcdvd gets a dynamic major.

Fixed is in -git since Mon May 15 09:44:40 2006 -0700.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVKPDEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVKPDEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVKPDEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:04:10 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:31534 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965189AbVKPDEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:04:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jdC9CvCqoE1VhFfe7k0cgV6FPLI+SpINZf917WSfXv6TzHgG5VPkSNiDDU/iMc+VbxlVJIZPn5z7S4tcUorKyLXgmzZ7u2n59DJPoJE+bCmy4hztPH6xubwm3AOZPV0arjSlr8dMiR21nN8y5glnl4PJ4l951I0rq/PReiDTw0g=
Message-ID: <437AA1A0.6080409@gmail.com>
Date: Wed, 16 Nov 2005 12:04:00 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com>
In-Reply-To: <4379EC82.1030509@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> The port stops, when any error occurs.  For device errors, set 
> PORT_CS_INIT bit in PORT_CTRL_STAT, then wait for Port Ready (bit 31, 
> see above).
> 

Yeap, this did the trick.  I'm working on SRST/init stuff and I think I 
can post patches later today.  What workload do you use for testing a 
ATAPI device?  I'm currently thinking of the following...

* mounting & tarr'ing cdrom & unmount
* repeat above with eject/load
* burning a cdrom
* ripping a music cd with cdparanoia

Any other thing I can try?

-- 
tejun

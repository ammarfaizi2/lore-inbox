Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRITWgB>; Thu, 20 Sep 2001 18:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274680AbRITWfx>; Thu, 20 Sep 2001 18:35:53 -0400
Received: from pD9E57B96.dip.t-dialin.net ([217.229.123.150]:35083 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S274684AbRITWfg>; Thu, 20 Sep 2001 18:35:36 -0400
Date: Thu, 20 Sep 2001 22:35:55 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Tim Walberg <twalberg@mindspring.com>, Hubert Mantel <mantel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010920223555.B8282@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Hubert Mantel <mantel@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com> <20010918174312.H6102@suse.de> <20010918105932.D19504@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010918105932.D19504@mindspring.com>; from twalberg@mindspring.com on Tue, Sep 18, 2001 at 10:59:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 10:59:32AM -0500, Tim Walberg wrote:
> On 09/18/2001 17:43 +0200, Hubert Mantel wrote:
> >>	
> >>	You only have one single SCSI adapter?
> >>	
> >>	I tried several things so far, and it seems you need the following to 
> >>	trigger the problem: You need at least two SCSI adapters that require 
> >>	different drivers (so two AHA2940s are not sufficient) and the drivers 
> >>	need to be loaded as modules.
> >>	                                                                  -o)
> 
> 
> I would amend that a bit - it doesn't seem to have to be only two SCSI
> drivers, because I've seen the same with a 2.4.9-ac9 system with aic7xxx
> (with sg, sd, and sr) combined with usb-storage (which also uses sd).
> Granted usb-storage is kinda pseudo-SCSI, but it's not truly a SCSI
> low level driver.
> 
> 				tw

As a datapoint: I have seen this when I "scsi remove-single-device"'d a disk
from my system. After re-adding it (at the same ID/LUN etc. in this case) 
/proc/partitions was OK again.

Two different Adaptec controllers driven by AIC7xxx, compiled into kernel,
no modules.

Thorsten


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |

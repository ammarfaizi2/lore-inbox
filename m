Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274642AbRIYLSL>; Tue, 25 Sep 2001 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274646AbRIYLSB>; Tue, 25 Sep 2001 07:18:01 -0400
Received: from hal.grips.com ([62.144.214.40]:57216 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S274645AbRIYLRw>;
	Tue, 25 Sep 2001 07:17:52 -0400
Message-Id: <200109251117.f8PBHv403687@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: "[A]ndy80" <andy80@ptlug.org>
Subject: Re: Burning a CD image slow down my connection
Date: Tue, 25 Sep 2001 13:17:56 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15loh3-0005PD-00@the-village.bc.nu> <1001412802.1316.4.camel@piccoli>
In-Reply-To: <1001412802.1316.4.camel@piccoli>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you use the scsi emulation for your writer you need to use hdparm on 
the original ide device that you passed to the emulation rather than the 
emulated scsi device.
eg use        hdparm -whatever /dev/hdc
     and not hdparm -whatever /dev/scd0 or /dev/cdrom 

On Tuesday 25 September 2001 12:13, [A]ndy80 wrote:
> Hi
> [root@piccoli shady]# hdparm -t /dev/cdrom
> /dev/cdrom not supported by hdparm
>
> What else ahve I to enable?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSGCMYJ>; Wed, 3 Jul 2002 08:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSGCMYJ>; Wed, 3 Jul 2002 08:24:09 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:17068 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315611AbSGCMYI>; Wed, 3 Jul 2002 08:24:08 -0400
Message-Id: <200207031226.g63CQND76592@d12relay01.de.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: Device Model Docs
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Mail-Copies-To: arndb@de.ibm.com
Date: Wed, 03 Jul 2002 16:26:21 +0200
References: <Pine.LNX.4.33.0207021420150.8496-100000@geena.pdx.osdl.net>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
 
> Everyone is encouraged to have a look. Feel free to send me comments,
> corrections, or patches.

In binding.txt, you write:
> Upon the successful completion of probe, the device is registered with
> the class to which it belongs. Device drivers belong to one and only
> class, and that is set in the driver's devclass field.

I have two drivers (drivers/s390/char/tape.c and drivers/s390/net/ctcmain.c)
that might have problems with this. S390 tapes are available through two
interfaces, a character device implementing the standard tape interface
and a block device that allows you to mount a filesystem written to a tape 
(unlike most tape drives, they allow random access reads).

CTC (channel to channel) is a point-to-point connection between two machines
and can be used either as a tty device or as a network device.

Do you have any idea how I can map this to correct driver classes?

        Arnd <><

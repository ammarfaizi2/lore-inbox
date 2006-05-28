Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWE1RgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWE1RgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWE1RgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:36:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:9559 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWE1RgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:36:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=elZ81b57ghTcfOfjDxB/F810it2AHMS8wQ624r4B8jWxokuobiWdeDMfix9xbsCwMs5vQPxXemLmwEGIKvDSBgGdobkj4947NaOdO5jq280Om2fGHUTaZPqA+k+ta3sgfUN55Z7eByosL1YRGSZk1T529msfCEPR4gatXmJ9yoA=
Message-ID: <4479DF88.2040500@gmail.com>
Date: Sun, 28 May 2006 19:35:45 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Nathan Laredo <laredo@gnu.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	<m3slmui1cr.fsf@zoo.weinigel.se> <4479D167.4020203@gmail.com> <m3odxihxvp.fsf@zoo.weinigel.se>
In-Reply-To: <m3odxihxvp.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel napsal(a):
> Jiri Slaby <jirislaby@gmail.com> writes:
> 
>> Christer Weinigel napsal(a):
>>> fixed in the driver.  If the card doesn't have a subvendor/subdevice,
>>> is there some way of doing a sanity check on the board to see if it
>>> actually is a stradis card and then release the board if it isn't?
>> Unfortunately not.
> 
> Why not?  There's an I2C bus with a bunch of devices on it.  Isn't it
> possible to do an I2C scan and if it doesn't match what's supposed to
> be on the card fail the probe and release the PCI resources?
This is an older method not used for device drivers, but only for searching for
busses or i2c et al, of which drivers stands aside and controls the device.
> 
> If there is no FPGA or the FPGA fails to respond, that should also be
> a fairly good indicator that it is not a stradis board.
Yup, but pci probing doesn't have such mechanism.
> 
> And it seems that at least some of the cards have a value in the
> subvendor field since the driver says "SDM2xx found" if
> pdev->subsystem_vendor is nonzero.  So how common are the rev1 boards
> (which I assume have zeroes in the subvendor/subdevice fields) and
> what does "lspci -vn" for the SDM2xx boards say?
If it happens that way, it's easy to add sub*ids into pci device id table too
and the problem will go away.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

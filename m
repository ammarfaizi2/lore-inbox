Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbSJOSDD>; Tue, 15 Oct 2002 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264817AbSJOSDC>; Tue, 15 Oct 2002 14:03:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2238 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264816AbSJOSCh>;
	Tue, 15 Oct 2002 14:02:37 -0400
Date: Tue, 15 Oct 2002 14:08:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC] device_initialize()
In-Reply-To: <Pine.LNX.4.44.0210151053040.1038-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210151405450.10323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Oct 2002, Patrick Mochel wrote:

> Overall, I agree with the concept of the patch. I wonder though if we 
> could do it without burdening all the callers of device_register() to 
> first call device_initialize(). Well, tastefully at least. 

I'd rather add device_add() and make device_register() call device_initialize()
followed by device_add()...

	BTW, my variant of the same beast is on
ftp.math.psu.edu/pub/viro/O/O142-device_add-C42
with uses in O14[3-6]* in the same place...


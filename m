Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281073AbRKOVa3>; Thu, 15 Nov 2001 16:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRKOVaU>; Thu, 15 Nov 2001 16:30:20 -0500
Received: from [216.80.8.1] ([216.80.8.1]:32272 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S281073AbRKOVaI>;
	Thu, 15 Nov 2001 16:30:08 -0500
Message-ID: <3BF433EE.40403@prairiegroup.com>
Date: Thu, 15 Nov 2001 15:30:22 -0600
From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <mailman.1005834780.32418.linux-kernel2news@redhat.com> <200111151807.fAFI7XN30496@devserv.devel.redhat.com> <3BF40D17.4060501@prairiegroup.com> <20011115141430.B10133@devserv.devel.redhat.com> <3BF41E17.5080200@prairiegroup.com> <20011115152432.A26630@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kinda sorta partial success


> "make modules_install", but this time rename hid.o into hid.hidden.
> Let me know if this fixes the problem.

I went ahead and did this. Booted up and got the expected error message 
when HID tried to load. Keyboard works but USB mouse ofcourse does not. 
So I went and renamed hid.hidden to hid.o and loaded it. Now my USB 
keyboard and USB mouse are working.

I suspect it has something to do with the order the modules are loaded? 
hid.o must be last? I am just guessing.

I suppose I can edit the rc.sysinit to load hid AFTER usbkbd is loaded.

Martin


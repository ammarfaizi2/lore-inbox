Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293291AbSBXGji>; Sun, 24 Feb 2002 01:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293292AbSBXGj3>; Sun, 24 Feb 2002 01:39:29 -0500
Received: from cs24344-28.austin.rr.com ([24.243.44.28]:48392 "EHLO
	explorer.dummynet") by vger.kernel.org with ESMTP
	id <S293291AbSBXGjS>; Sun, 24 Feb 2002 01:39:18 -0500
Date: Sun, 24 Feb 2002 00:39:15 -0600
From: Dan Hopper <dbhopper@austin.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224063915.GA2799@yoda.dummynet>
Mail-Followup-To: Dan Hopper <dbhopper@austin.rr.com>,
	Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224062124.GB15060@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> remarked:
> These patches will not apply for the 2.4 tree, even if you tried :)
> 
> What problems are you having with 2.4.18-rc1 and previous?  Any oops
> messages?

Hi,

Well, basically if I use usb-uhci instead of uhci, the computer
locks during the shutdown process.  I believe I've used the stock
Mandrake 8.1 kernel as well as 2.4.17 and 2.4.18-rc1 with similar
results.  Mandrake even seems to make a note of the issue:

http://www.linux-mandrake.com/en/errata.php3

"Error scenario: The computer locks up when shutting down or when
  stopping the usb service.
Why: In certain cases, the usb-uhci module is broken for some usb
  devices. 
Solution: Modify your /etc/modules.conf file and change the line
  "alias usb-interface usb-uhci" to "alias usb-interface uhci". The
  change will take effect after the next shutdown and will prevent the
  usb service from locking up the computer."


I have a Brother HL-1450 Postscript printer and an HP Scanjet 6300C
attached, FWIW.

The reason I'd like to switch back to usb-uhci instead of uhci is
twfold:  Vmware seems to want to only use usb-uhci and not uhci
(dummies!).  And uhci seems to be unable to get the scanner going
such that it doesn't "stutter" all the way down the page.  usb-uhci
seems to be able to keep up so that it just sweeps on down the page.

I saw the thread on usb-uhci on 2.5, and it looked so similar that I
(incorrectly) assumed them to be one and the same problem.

Thanks,
Dan

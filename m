Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQLHBxp>; Thu, 7 Dec 2000 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbQLHBxg>; Thu, 7 Dec 2000 20:53:36 -0500
Received: from [209.143.110.29] ([209.143.110.29]:7443 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S130067AbQLHBxW>; Thu, 7 Dec 2000 20:53:22 -0500
Message-ID: <3A3037E9.6D5378A8@the-rileys.net>
Date: Thu, 07 Dec 2000 20:22:52 -0500
From: David Riley <oscar@the-rileys.net>
Reply-To: oscar@the-rileys.net
Organization: The Rileys
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Bryan Whitehead <driver@rccacm.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disableing USB.
In-Reply-To: <Pine.LNX.4.21.0012071438020.3776-100000@www.rccacm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Whitehead wrote:
> 
> Is there a way I can disble a part of the kernel that is compiled into the
> kernel? For example I'd like to pass this to lilo: "usb=disable" and then
> the usb code is not loaded even though USB has been built into the kernel.
> 
> Is such a feature stupid? Or has this already been implemented?
> 
> It would be nice if this was generic and I could also pass things like
> "procfs=disabled".
> 
> The resone I ask is a friend of mine got a new Sony Vaio Laptop that has
> the ethernet card and USB device stepping on eachother. It would be nice
> to pass to the Redhat/Mandrake/whatever installation boot disk usb=disable
> so the ethernet card can work freely (he's doiung a ntwork install becasue
> he has no CD-ROM), as he doesn't use any USB devices anyway.

Er... Well, the traditional solution has been "don't build it into your
kernel if you don't want it", but in the case of stock kernels, that
isn't always an option, I suppose.  Theoretically, the two devices
shouldn't step on each other, but this is a computer.  Theory is so far
removed from practice that it's... Well, I can't think up a good
analogy.  It's far.

*looks at kernel config options*

Well, it looks like the usb cores (UHCI and OHCI) can be modular.  Why
aren't they in the stock kernel, other than possibly autodetection
problems?  If they are built as modules, using expert mode in RedHat or
whatever equivalent may be in other dists may let you avoid insmodding
the USB stuff...

Beyond that, having a command-line disable feature does seem pretty
neat.  Although why would you want to disable procfs?  Maybe I missed
something there, but it seems awful darn important to leave out. :-)

-- 
"Windows for Dummies?  Isn't that redundant?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

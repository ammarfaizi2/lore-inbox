Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313063AbSC0TBB>; Wed, 27 Mar 2002 14:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313071AbSC0TAv>; Wed, 27 Mar 2002 14:00:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:12602 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313063AbSC0TAo>;
	Wed, 27 Mar 2002 14:00:44 -0500
Message-ID: <3CA216C2.8CA0D6F5@gmx.net>
Date: Wed, 27 Mar 2002 20:00:18 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>,
        linux-kernel@vger.kernel.org
Subject: Re: USB Microsoft Natural KeyB not recogniced as a HID device
In-Reply-To: <20020325183011.GA29011@kroah.com> <Pine.LNX.4.30.0203251957590.5375-200000@stud.fbi.fh-darmstadt.de> <20020325192216.GD29011@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Mon, Mar 25, 2002 at 08:07:21PM +0100, Jan-Marek Glogowski wrote:
> > Hi Greg
> >
> > [schnipp]
> > > Can you try the patches at:
> > >       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684196109355
> > > and also:
> > >       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684207509482
> > >
> > > And let us know if they help you out?
> > [schnapp]
> >
> > Applied both patches - the keyboard is detected again, but I still have
> > some errors in the lsusb-output (see attachment).
>
> Sounds like a device that is lying about it's strings.  If the device
> works, I wouldn't worry about it :)

Greg, bad guessing. This is not the device's fault but the linux usb
drivers are buggy.

The messages:
        bInterfaceClass cannot get string descriptor 1, error = Broken
pipe(32)
        cannot get string descriptor 2, error = Broken pipe(32)

go away after "rmmod hid" (or whatever driver is using the device).

This is a long standing bug.

Regards, Gunther


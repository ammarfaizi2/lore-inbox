Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSGBERc>; Tue, 2 Jul 2002 00:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSGBERb>; Tue, 2 Jul 2002 00:17:31 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:32747 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316604AbSGBERb>; Tue, 2 Jul 2002 00:17:31 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Ralph Corderoy <ralph@inputplus.co.uk>, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Date: Tue, 2 Jul 2002 14:16:42 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <200207011647.g61GlNx14474@blake.inputplus.co.uk>
In-Reply-To: <200207011647.g61GlNx14474@blake.inputplus.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207021416.42616.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002 02:47, Ralph Corderoy wrote:
> Hi Pete,
>
> > > My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> > > being generated, unlike hid.o which didn't used to but does now.
> >
> > I have an idea: remove usbkbd or make it extremely hard for newbies to
> > build (e.g. drop CONFIG_USB_KBD from config.in, so it would need to be
> > added manually if you want usbkbd).
>
> That doesn't sound too great.
Actually, it would probably avoid a lot of unhappy users, and I am a strong 
advocate of total removal of the code, config option, everything. The only 
downside is slightly larger code size for hid.o vs usbkbd.o.

Unfortunately, removal has been vetoed by the USB Maintainer based on the code 
size issue.

Hmm, maybe we can add a particularly inefficient ErrorRollover handling case 
to usbkbd :-)

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

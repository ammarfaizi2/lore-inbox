Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVDNXEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDNXEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVDNXEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:04:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4737 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261635AbVDNXD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:03:57 -0400
Subject: Re: Linux support for IBM ThinkPad Disk shock prevention update...
From: Lee Revell <rlrevell@joe-job.com>
To: abonilla <abonilla@linuxwireless.org>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050414224215.M94640@linuxwireless.org>
References: <200504141658.50135.shawn.starr@rogers.com>
	 <1113513316.19373.22.camel@mindpipe>
	 <20050414224215.M94640@linuxwireless.org>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 19:03:51 -0400
Message-Id: <1113519832.19830.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 18:46 -0400, abonilla wrote:
> On Thu, 14 Apr 2005 17:15:16 -0400, Lee Revell wrote
> > On Thu, 2005-04-14 at 16:58 -0400, Shawn Starr wrote:
> > > We just need to figure
> > > out to get the specs from IBM
> > 
> > Best bet is probably reverse engineering it...
>  
> Lee, 
> 
> I know this is far from easy... but, What do we need to do this? I haven't
> seen such a cooler feature in a Thinkpad like the HDAPS. (Well, maybe the
> fingerprint reader) But, how can we / I help, if this is ever done?
> 

Please see:

http://dxr3.sourceforge.net/re.html

I have discovered several previously unknown emu10k1 hardware features
using this procedure to reverse engineer the Windows drivers, including
a per channel half loop interrupt, and added support to the Linux driver
for some of them.

It may be much easier to find the read and write register subroutines
than in the above guide.  The Windows driver I was working with had
exactly one subroutine that used the inb, inl, inw, outb, outw, outl
instructions, so it was trivial to set breakpoints to log all the port
I/O.  I later found it was even easier, the version of SoftIce I was
using allows you to set I/O breakpoints, so all you need to start
logging the register activity is the port.

I had a little trouble loading the IDA symbols into SoftICE at first,
just because the first few scripts I found on the net didn't work.

Some devices use memory mapped IO, I have no idea how you would RE
these.  Maybe someone else has some pointers?

Lee


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRIFMNo>; Thu, 6 Sep 2001 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272402AbRIFMNf>; Thu, 6 Sep 2001 08:13:35 -0400
Received: from home.paris.trader.com ([195.68.19.162]:8421 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S270467AbRIFMNT>; Thu, 6 Sep 2001 08:13:19 -0400
Message-ID: <3B97688E.BD639152@trader.com>
Date: Thu, 06 Sep 2001 14:14:06 +0200
From: joseph.bueno@trader.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Thompson <Phil.Thompson@pace.co.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: User Space Emulation of Devices
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Thompson wrote:
> 
> Without going into the gory details, I have a requirement for a device
> driver that does very little apart from pass on the open/close/read/write
> "requests" onto a user space application to implement and pass back to the
> driver.
> 
> Does anything like this already exist?
> 
> Thanks,
> Phil
> -

Hi,

You may use pseudo-terminals (pty) to pass open/close/read/write/ioctl requests
to user space.

Your monitoring application opens master side of the pseudo terminal and
monitored application opens slave side.

Ptys are mainly used to redirect serial device communications (tty) to user
space but they can also be used to emulate other types of devices.
Check pty man pages for details.

Hope this helps
--
Joseph Bueno
NetClub/Trader.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUDKNZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 09:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUDKNZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 09:25:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262339AbUDKNZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 09:25:35 -0400
Date: Sun, 11 Apr 2004 14:25:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: daniel.ritz@gmx.ch, "'Thomas Charbonnel'" <thomas@undata.org>,
       ccheney@debian.org, linux-pcmcia@lists.infradead.org,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news
Message-ID: <20040411142527.A29837@flint.arm.linux.org.uk>
Mail-Followup-To: Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
	'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org,
	linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	'Tim Blechmann' <TimBlechmann@gmx.net>
References: <200404100347.56786.daniel.ritz@gmx.ch> <20040410033032.XOVD8029.smtp1.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040410033032.XOVD8029.smtp1.fuse.net@64BitBadass>; from ico@fuse.net on Fri, Apr 09, 2004 at 11:30:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Note: I've dropped one of the mailing lists from the CC line because
they appear to have zero interest in my messages.)

On Fri, Apr 09, 2004 at 11:30:31PM -0400, Ivica Ico Bukvic wrote:
> I am aware that this burst stuff should be enabled on the 2.6 kernel,
> however I am still getting bad results.

Are you saying that you have tried the 2.6.5 kernel?

> The 06 to 04 may be the critical element as even when I have everything
> properly running in Win32, when I alter this number the distortion returns

$ setpci -s a.0 0xc9.b

will display the value of this register under Linux, and:

$ setpci -s a.0 0xc9.b=value

will set it to the desired value.  However, check that a.0 is the
cardbus bridge first by using:

$ lspci

> If I do figure out the problem in Linux and find out that a particular
> register is the issue, how can I make my linux box adjust this register at
> boot-time (a simple hack-like script in a form of a service comes to mind
> but I was hoping to perhaps see a more universal solution if possible)?

The correct solution is to put a quirk into the kernels yenta driver,
but we'd need the results from your testing first.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

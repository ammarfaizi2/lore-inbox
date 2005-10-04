Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVJDVPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVJDVPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVJDVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:15:51 -0400
Received: from free.hands.com ([83.142.228.128]:40084 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S964980AbVJDVPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:15:51 -0400
Date: Tue, 4 Oct 2005 22:15:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004211537.GI10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4342DC4D.8090908@perkel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 12:47:25PM -0700, Marc Perkel wrote:

> The bootup sequence of Linux is pathetic. What an ungodly mess. The 
> FSTAB file needs to go and a smarter system needs to be developed. I 
> know this isn't entirely a kernel issue but it is somewhat related.
 
 depinit.  written by richard lightman.  easily located with google.

 on relatively inexpensive amd 2100 hardware, depinit results
 in a startup time to console login of 5 seconds, and x-windows
 in a further 3.


 this is probably as good a time as any to mention this:

 depinit on a 2.6 kernel has had to have a small script added which does
 a sleep 3; kill -HUP <itself> - i.e. "kill -HUP 1".

 if this is not done, then any child program that sends a signal to
 process 1 is NOT SEEN.

 richard believes the problem to be actually in the 2.6 kernel.

 whilst /sbin/init only catches one signal, depinit catches quite
 literally _all_ of them.

 i'm relaying this from memory, so some of the above may be inaccurate.


> I think development needs to be done to make the kernel cleaner and 
> smarter rather than just bigger and faster. 

 actually, on embedded systems the linux 2.6 kernel is bigger
 and slower, which has prompted a large number of embedded systems
 designers to stick with the [by now abandoned] 2.4 series.

> Marc Perkel
> Linux Visionary
  ^^^^^ ^^^^^^^^^
 wha-heeeeey !

 
 my main concern, btw, is that by the time linux kernel developers
 "receive hardware to play with", it's already too late.

 the hardware decisions have already been made.

 you - worthy as you are and the work you are doing is -
 are treated as second class citizens by the companies
 manufacturing hardware.

 time to put the horse before the cart.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

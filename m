Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJZMqX>; Fri, 26 Oct 2001 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276803AbRJZMqN>; Fri, 26 Oct 2001 08:46:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276330AbRJZMqE>; Fri, 26 Oct 2001 08:46:04 -0400
Subject: Re: Other computers HIGHLY degrading network performance (DoS?)
To: anuradha@gnu.org (Anuradha Ratnaweera)
Date: Fri, 26 Oct 2001 13:53:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011026084328.A14814@bee.lk> from "Anuradha Ratnaweera" at Oct 26, 2001 08:43:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15x6U0-0008Hs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a popular software that runs on MS platform called "download
> accelerator".  This opens several threads for a download job (each one
> downloading a portion of the file), sometimes even using mirror sites.
> However, it not only grabs whole bandwidth, but makes it hard for other
> machines to even ping each other the return time being around 5-10 seconds on a
> 100 Mbps network!  The download process is getting only 64 kbps from the
> Internet.  Internet access is virtually impossible for the other machines.

Firewall them off. There are also apache hacks for spotting the 
download accelerator device and blocking the user for good.

> I monitored network traffic with tcpdump, and noticed that those packets don't
> have tcp timestamps and tcp sack.  I turned them off on my Linux box using
> sysctl, and also tried turning on ECN without success.

They will tend to come from older windows boxes, the timestamp/sack stuff
is unrelated

> This is of course a DoS in disguise, and is there a way to stop it?

Turning off byte range support in the web server works suprisingly well for
it. Another non hacking code approach would be to set up CBQ or other
bandwidth limiters so that the users of download accelerator get no
benefit. The advantage of the apache hacks is that you can make them
actually suffer

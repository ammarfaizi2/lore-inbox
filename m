Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbTCNT5E>; Fri, 14 Mar 2003 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263474AbTCNT5E>; Fri, 14 Mar 2003 14:57:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31506 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263320AbTCNT5D>; Fri, 14 Mar 2003 14:57:03 -0500
Date: Fri, 14 Mar 2003 20:07:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Adam J. Richter'" <adam@yggdrasil.com>, driver@jpl.nasa.gov,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030314200746.I23686@flint.arm.linux.org.uk>
Mail-Followup-To: Ed Vance <EdV@macrolink.com>,
	"'Adam J. Richter'" <adam@yggdrasil.com>, driver@jpl.nasa.gov,
	dwmw2@infradead.org, linux-kernel@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D1A33DE3@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DE3@EXCHANGE>; from EdV@macrolink.com on Fri, Mar 14, 2003 at 11:49:54AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 11:49:54AM -0800, Ed Vance wrote:
> Anybody know of any other (worse) technical issues with PCI/setserial 
> on the 2.4 kernels?

Please note that one of the things I've recently done is to put a lot
of effort into re-working the PCI serial code in 2.5, hopefully without
breaking too much other stuff.  It works here with my, ah hem, limited
PCI serial devices.

One of the areas I've tried to improve is our "port guessing" algorithm.
Hopefully, this will allow more serial cards to just work like the one
which started this thread, but only time will tell if this is successful.

It hasn't hit Linus' tree yet, so please don't go looking there for it
yet.

I'm also not going to suggest backporting it to 2.4 either, but if some
one is feeling brave enough, they're welcome to try (this is what Open
Source is all about!) 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


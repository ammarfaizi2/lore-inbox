Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSFGW2N>; Fri, 7 Jun 2002 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317203AbSFGW2M>; Fri, 7 Jun 2002 18:28:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46096 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316960AbSFGW2M>;
	Fri, 7 Jun 2002 18:28:12 -0400
Message-ID: <3D013329.E872EAE2@zip.com.au>
Date: Fri, 07 Jun 2002 15:26:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bourne <jbourne@mtroyal.ab.ca>
CC: linux-kernel@vger.kernel.org, gibbs@plutotech.com
Subject: Re: 2.4.18 AIC7XXX hard lockup
In-Reply-To: <Pine.LNX.4.44.0206070726060.27407-102000@skuld.mtroyal.ab.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bourne wrote:
> 
> Hi,
> We are currently running 2.4.18 (Marcelo) on a Dell PE4400 with
> Perc3/DC and 2 on board adaptec controllers (two 7899 channels and one
> 7880).
> 
> On the first 7899 channel we have attached 2 Quantum DLT 7000 drives and a
> BHTi Quad 7 changer, on the second there are another 2 Quantum DLT
> 7000 drives and a BHTi Q2 changer as well as the internal CDROM.
> 
> Now, what is happening is when we are initializing the JBs, the host
> system will abruptly hang.  Turning on aic7xxx=verbose on the kernel
> command line has given additional output, but still nothing solid as far
> as trouble shooting information.  The only information I have been
> able to get out of it has been:
> 
> scsi1:0:6:0: Attempting to queue an ABORT message
> 
> This is the stock 6.2.4 adaptec driver in 2.4.18 and with the 6.2.5 driver
> under 2.4.18 (I've patched and tested this one today).  Attached are
> kernel log segments of the information from boot to hang for 6.2.4 and
> 6.2.5 driver revisions...
> 

It does that for me in 2.5 as well, very occasionally.

Try booting with the `nmi_watchdog=1' kernel boot option,
and see if that catches a backtrace.

-

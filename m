Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSFZHvi>; Wed, 26 Jun 2002 03:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSFZHvh>; Wed, 26 Jun 2002 03:51:37 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:57538 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S316339AbSFZHvg>; Wed, 26 Jun 2002 03:51:36 -0400
Date: Wed, 26 Jun 2002 09:50:27 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE Error - 2.5.24 - Whats this?
Message-ID: <20020626075027.GA18667@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org
References: <1025068858.5090.1.camel@coredump>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025068858.5090.1.camel@coredump>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 01:20:57AM -0400, Shawn Starr wrote:
> I got this message this evening from the syslog:
> 
> 
> MCE: The hardware reports a non fatal, correctable incident occured on
> CPU 0.
> 
> Bank 0: 9409c00000000136
> 
> 
> Is this something I should be worried about?
> 
> Included is the standard dmesg.

Dave Jones had a small parser for these codes:
http://www.codemonkey.org.uk/cruft/parsemce.c

And as it seems the parser lacks a bit of information to completely
decode the message:

~ ./parsemce
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): 9409c00000000136 @ 0
        External tag parity error
        Uncorrectable ECC error
        CPU state corrupt. Restart not possible
        MISC register information valid
        Error not corrected.
        Error overflow
        Memory heirarchy error
        Request: Generic error
        Transaction type : Data
        Memory/IO : I/O

> Linux version 2.5.24 (root@unknown) (gcc version 3.1) #1 Sat Jun 22 14:58:48 EDT 2002
...

-alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272793AbRILNcX>; Wed, 12 Sep 2001 09:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272797AbRILNcN>; Wed, 12 Sep 2001 09:32:13 -0400
Received: from ns.ithnet.com ([217.64.64.10]:43019 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272793AbRILNcH>;
	Wed, 12 Sep 2001 09:32:07 -0400
Date: Wed, 12 Sep 2001 15:32:16 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: ajit k jena <ajit@indica.iitb.ac.in>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Quantum DLT 4000 + HP C5173-4000
Message-Id: <20010912153216.0687793a.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109121004380.7146-100000@indica.iitb.ac.in>
In-Reply-To: <Pine.LNX.4.33.0109121004380.7146-100000@indica.iitb.ac.in>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001 10:05:17 +0530 (IST) ajit k jena <ajit@indica.iitb.ac.in>
wrote:

> 
> Hi,
> [...] 
> Then I use the mt command as below:
> 
> 	mt -f /dev/st0 status
> 
> 	the output is:
> 
> 	SCSI 2 tape drive:
> 
> 	File number = 0, block number=0, partition=0
> 	Tape block size 0 bytes, Density code 0x1a
> 				(unknown to this mt)
> 	Soft error count since last status=0
> 	General status bits on (41010000):
> 		BOT ONLINE IM_REP_EN

That seems to be normal. I have the merely the same output on a HP Surestore
DLT.

> I am using HP 1/2" DLTtape IV Data cartridge.
> 
> When I try to do a tar onto the tape, I get the message:
> 
> 	Wrote only 0 of 10240 bytes
> 	Error is not recoverable: exiting now

Try to set a valid blocksize _before_ tar. Like mt setblk 32768.
DLT may have problems otherwise. Find a correct blocksize in your manual.

Regards,
Stephan



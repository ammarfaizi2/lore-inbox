Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSAPRRq>; Wed, 16 Jan 2002 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAPRRg>; Wed, 16 Jan 2002 12:17:36 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:5291 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S279798AbSAPRRZ>; Wed, 16 Jan 2002 12:17:25 -0500
Message-ID: <3C45B715.926A0BA0@nortelnetworks.com>
Date: Wed, 16 Jan 2002 12:23:33 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mcuss@cdlsystems.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring execution time
In-Reply-To: <Pine.LNX.4.33.0201151409270.1744-100000@barbarella.hawaga.org.uk> <042f01c19e13$6da6f4f0$160e10ac@hades>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Cuss wrote:

> I am working on optimizing some software and would like to be able to
> measure how long an instruction takes (down to the clock cycle of the CPU).
> I recall reading somewhere about a kernel time measurement called a "Jiffy"
> and figured that it would probably apply to this.
> 
> If anyone has any tips on how to figure out how to do this I'd really
> appreciate it.

Jiffies are quite coarse-grained.  On x86 you want the rdtsc instruction, while
on ppc you want mfrtcu/mfrtcl or mftbu/mftb depending on the version of the
chip.  These are used as inline assembly, and if you do a google search you
should be able to find code snippets.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

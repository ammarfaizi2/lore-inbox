Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316529AbSEPATq>; Wed, 15 May 2002 20:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSEPATo>; Wed, 15 May 2002 20:19:44 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:40716 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316529AbSEPASL>; Wed, 15 May 2002 20:18:11 -0400
Date: Wed, 15 May 2002 17:18:06 -0700
From: jw schultz <jw@pegasys.ws>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: "'linux-kernel@vger.kernel.org.'" <linux-kernel@vger.kernel.org>
Subject: Re: Device driver question
Message-ID: <20020515171806.L840@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"Bloch, Jack" <Jack.Bloch@icn.siemens.com>,
	"'linux-kernel@vger.kernel.org.'" <linux-kernel@vger.kernel.org>
In-Reply-To: <180577A42806D61189D30008C7E632E87938E1@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 09:17:21AM -0400, Bloch, Jack wrote:
> I am relatively new to Linux (< 6 months). We have designed an embedded
> system (on compact PCI) running on a Pentium III 700Mhz cPCI machine. This
> machine supports upt to 6 cPCI boards for specific functions (this is our
> own HW). I have already written the device drivers for these boards and the
> system is running. I have a specific case where our HW can generate a
> special interrupt. In this case I simply want the ISR to halt the system
> (i.e. take the same action as if I typed halt from the command line). How
> can I from within my device driver cause a halt? Please CC me specifically
> on any replies.
> 
> Thanks in advance. 

I am assuming you are running more than just the kernel.
You could just post a signal to init (pid 1).
SIGINT would be a top candidate.

Take a look at powerd, init and inittab.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

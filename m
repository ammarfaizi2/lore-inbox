Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUDZLh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUDZLh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUDZLh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 07:37:28 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:45749 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S264488AbUDZLhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 07:37:24 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Mon, 26 Apr 2004 21:41:24 +1000
User-Agent: KMail/1.5.1
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
References: <200404131117.31306.ross@datscreative.com.au> <20040422163958.GA1567@tesore.local> <1082654469.16333.351.camel@dhcppc4>
In-Reply-To: <1082654469.16333.351.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404262141.24616.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 03:21, Len Brown wrote:
> On Thu, 2004-04-22 at 12:39, Jesse Allen wrote:
> 
> > On the Shuttle AN35N, the C1 disconnect option default is auto.  If you're
> > talking about this board, or another board Shuttle seemingly fixed, then I
> > can tell you that I haven't been able to get my to hang with vanilla kernels.
> 
> Have you been able to hang the AN35N under any conditions?
> Old BIOS, non-vanilla kernel?
> 
> > As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
> > The only patch that seemed to work without a fast timer so far was the one 
> > removed by Linus in a testing version.  The AN35N has the timer override 
> > bug.
> 
> Hmm, I didn't notice fast time on my FN41, i'll look for it.
> 
> I'm not familiar with the "one removed by Linux in a testing version",
> perhaps you could point me to that?

This is Maciej's patch - latest posting of it that I have seen,
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html

His fix up of the 8259 ack issue (when used without routing 8254 pit into
io-apic INTIN0) successfully establishes a virtual wire mode input of the timer
which the nforce2 seems happy with albeit without being able to use
"nmi_debug=1"

It is that timer ack issue tied up with the integrated apic.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/2143.html

This refers to when it was in the 2.6.3-rc1-mm1
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/2658.html 

Regards
Ross.

> 
> > Attached is the dmidecode for the AN35N.
> 
> applied.
> 
> thanks,
> -Len
> 
> 
> 
> 
> 


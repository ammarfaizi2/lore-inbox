Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRCMXEL>; Tue, 13 Mar 2001 18:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131259AbRCMXEB>; Tue, 13 Mar 2001 18:04:01 -0500
Received: from monza.monza.org ([209.102.105.34]:3848 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131255AbRCMXDr>;
	Tue, 13 Mar 2001 18:03:47 -0500
Date: Tue, 13 Mar 2001 15:02:21 -0800
From: Tim Wright <timw@splhi.com>
To: Nathan Walp <faceprint@faceprint.com>
Cc: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
Message-ID: <20010313150221.A2524@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Nathan Walp <faceprint@faceprint.com>,
	David Balazic <david.balazic@uni-mb.si>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AAE4DB6.8349ACBA@uni-mb.si> <3AAE7406.283D2411@faceprint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAE7406.283D2411@faceprint.com>; from faceprint@faceprint.com on Tue, Mar 13, 2001 at 02:24:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 02:24:54PM -0500, Nathan Walp wrote:
> David Balazic wrote:
> > 
> > SCSI adapters are enumerated randomly(*) , relying on certain numbering
> > will get you into trouble, sooner or later.
> > There is no commonly accepted solution, AFAIK.
> > The same thing can happent to disk enumeration ( sdb becomes sdc )
> > or partition enumeration ( hda6 becomes hda5 ).
> > 
> > * - theoreticaly no, but practicaly yes ( most of the time )
> 
> SCSI adapters are given host numbers in a random order?  Even with no
> hardware changes?  Does this make less than sense to anyone else?  Every
> kernel EVER up till now has had the real scsi cards (in some particular
> order) then ide-scsi.  Have I just been lucky???
> 

No, it's not truly random. That would be insane. And, no, if you don't change
the kernel or the hardware, then they won't jump around.
But, yes, if you change the hardware, or someone changes the probe order
in the kernel, you can suffer from device name slippage. This is a minor
problem on a small home system, and a massive PITA on a large server.
You can at least mandate the probe order on a 2.4 system (see the scsihosts
parameter).

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI

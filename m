Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRDBU1q>; Mon, 2 Apr 2001 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRDBU1i>; Mon, 2 Apr 2001 16:27:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:43238 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131316AbRDBU10>;
	Mon, 2 Apr 2001 16:27:26 -0400
From: "Richard A. Smith" <rsmith@bitworks.com>
To: "andre@linux-ide.org" <andre@linux-ide.org>,
   "Padraig Brady" <Padraig@AnteFacto.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   "Steffen Grunewald" <steffen@gfz-potsdam.de>
Date: Mon, 02 Apr 2001 15:25:25 -0500
Reply-To: "Richard A. Smith" <rsmith@bitworks.com>
X-Mailer: PMMail 2000 Professional (2.20.2030) For Windows 98 (4.10.2222)
In-Reply-To: <Pine.LNX.4.10.10104020738550.12531-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Cool Road Runner (was CFA as Ide.)
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: RSmith@bitworks.com
Message-ID: <MDAEMON-F200104021529.AA291937MD92027@bitworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001 21:57:12 -0700 (PDT), Andre Hedrick wrote:

>> OK can we just have a technical discussion?

>Please, lets do, I am tired of the battles

Me three... I am much better at tech than flames although I seemed to have missed all the 
flambe.

BTW... why is this thread called Road Runner?

>>      I.E. no need for PCMCIA or any of that. I understood from your 
>> responses that you didn't realise this?

>This valid that I do not know everything and that CFA does interesting
>things more than what was specified in the past.

The converse is true as well.. Having only used the CFA devices as solid state IDE drives I 
was unaware that there were any that didn't do the True IDE mode.

>Sorry phone call and email got mixed togather.
>But I did explain that there could be a failure to detect if PDIAG/DASP
>if one or the other devices was held to long and the wrong device reported
>a signature in the task register.  Also that the if you reversed the two
>device it would correctly report always.

Yes... Now that I am up on the docs I see exactly how this can happen.  Mishandled signals 
would cause device 0 to go 30 seconds before it gave up on Device 1.

Andre, do you think it's reasonable to assume that if most PC BIOS's will detect the CFA then 
it probally is handling the POR sequence and EXECUTE DEVICE DIAGNOSIC correctly?
If so then I feel pretty confident that it should work ok.. Over the 2 years we have been 
using CFAs as solid state HD's I have never seen a case where the BIOS didn't autodetect it 
properly as master or slave or have I had a problem with a long timeout.  I have plugged it 
up to all manner of machine old and new.. An the usual configuration was that the CFA was 
Device 0 and some random IDE drive we have laying around was device 1.

Now I am not saying it won't happen.. just that I haven't seen it.

>Not quite, the electronic differences and flash in native mode is
>incompatible, if you put it in to a mode that is 5V compatable then it
>does seem possible and reasonable to work.  Your imperical data points
>verify this issue.

Not to mention that the datasheet for the device indicates that this is possible and intended  
not just happenstance.  *grin*

>What really needs to happen is that all the devices that are CFA-like
>which require name parsing for detecting should have the "flash" rule
>imposed.  Whereas the ones that correctly report 0x848A for word 0 of the
>identify page may be exempt.

Yes I think so... Although I haven't done a rigorous reading of the SanDisk datasheet I 
haven't found anything so far that would lead me to believe that operates any different than 
an ATA-2 device when operating in True IDE mode.

IIRC SanDisk was the original people to come out with IDE CFA and everyone else just copied 
them.  I have the SanDisk datasheets that I can send you if you need them to verify stuff.  I 
believe that if you verify it with the SanDisk then all the other MFG's should work as well.

--
Richard A. Smith                         Bitworks, Inc.               
rsmith@bitworks.com               501.846.5777                        
Sr. Design Engineer        http://www.bitworks.com   



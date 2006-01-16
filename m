Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWAPVc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWAPVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWAPVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:32:57 -0500
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:48809 "EHLO
	smtp-1.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1751215AbWAPVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:32:56 -0500
Date: Mon, 16 Jan 2006 13:32:50 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Willy TARREAU <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <43CC079D.5060008@drugphish.ch>
Message-ID: <Pine.LNX.4.64.0601161328480.12751@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
 <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch>
 <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu> <20060115224642.GA10069@w.ods.org>
 <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu> <43CC079D.5060008@drugphish.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Roberto Nibali wrote:

>>> Thanks for the precision. So logically we should expect it to break 
>>> sooner or later ?
>> 
>> It is the same .config as one that crashed before, except that it has 
>> DEBUG_SLAB defined.  If it does not crash, then adding pci=noacpi to 
>> the command fixes the problem for me.
>
> Hmm, I'm not fully convinced yet, however glad that it has been a bit 
> more stable for you.

The stability only lasted for a week.  Last night I got another bad pmd 
message, an oops, and a hang.  I was not able to capture the oops.

> Sidenote: We boot our systems having built-in AIC7* SCSI on moderately 
> cheap motherboards with "bad" interrupt routing using pci=noacpi on 
> 2.4.x kernels to evade instability.
>
> I suggest that if you experience more problems using this setup _and_ 
> would like to continue debugging the issue, we take this off-list into a 
> private discussion.

At this point, I'm going to stick with 2.6.  If I get more time to debug 
this laster, I'll drop back down to the modified 2.4 with HIGHIO disabled.

> [Another thing which would be interesting to test regarding the HIGHIO 
> setting is a RedHat based 2.4.x kernel, since according to some SCSI 
> driver's documentation, RedHat had a different HIGHIO convention.]

Thanks.  I'll keep that on my list of things to try if I ever get back to 
this.  I appreciate the pointers.


-Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFJPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFJP2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:28:06 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:50954 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263183AbTFJPZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:25:10 -0400
Date: Tue, 10 Jun 2003 09:38:31 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <23050000.1055259511@caspian.scsiguy.com>
In-Reply-To: <20030610122326.13fe8889.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>	<122650000.1055172730@caspian.scsiguy.com> <20030610122326.13fe8889.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Stephan,
>>
>> Other than your most recent complaint that the driver doesn't function
>> correctly in an SMP kernel when you specify the nosmp option, you have
>> yet to provide any information that points to a problem in the aic7xxx
>> driver.
>
> Dear Justin,
>
> I am really not complaining about you not helping specifically _me_, I am
> complaining about your quite visible general opinion that this whole thing is
> really not serious, or maybe it is only that you are not making your efforts
> transparent to others, I don't know.

I never said that it wasn't serios, I just haven't seen any indication
that this problem is caused by my driver.  There is a big difference.
If your complaint is that I typically help people to solve their problems
*off-list*, then I'm sorry if that offends your sensibilities.
I personally don't think that I need to CC a million people while I'm
passing back various debugging information and asking for new output.  Its
just a lot of noise for the majority of people on the linux-kernel list.

>>  Without such information, I'm at a loss to help you.  One thing
>> that you forgot to mention in your "report" is that data corruption can
>> happen in many more places than just in the aic7xxx driver.
>
> <sarcasm>Did I mention the big magnet right beside the tape?</sarcasm>

I'm just sick of being blamed for anything that goes wrong on any system
that happens to have an aic7xxx controller in it.  99% or the time its
not my fault, but I suppose since I debug and resolve these issues off
list for people that contact me, the general assumption is that these
issues are the aic7xxx driver's fault.

>>  The data could be corrupted by a VM bug,
>
> VM is quite the same, tar'ing to /dev/tape or /var/bak/mybackfile.tar.

No, the VM activity is quite different.

>> a buffer layer bug, or a filesystem bug.
>
> /dev/tape with a filesystem? Have you read what we are talking about?

Where did you get the data to place on the tape?  /dev/zero?

>>  When testing our drivers against RHAS2.1 we found that the stock
>> kernel had data corruption issues very similar to what your are talking
>> about when run on very fast, hyperthreading, SMP machines.  The data
>> corruption occurred with any SCSI controller we tried, regardless of vendor.
>
> My question is: is it solved?

My understanding is that it was fixed in 2.4.18 level kernels, but since
I don't know the root cause of the corruption, it could have just been
made more difficult to reproduce.

>> If you continue to feel that the aic7xxx driver is at fault, I encourage you
>> to try to reproduce this failure with someone elses card.  I think you'll
>> find that the problem persists even with this change.
>
> This is not the first discussion about an instability in aic.

I'm not talking about *every case of aic7xxx driver instability*, I'm
talking about *this particular case* of driver instability.  Problems
that to the naive user look similar are typically not.

>> I will be more than happy to look into why the aic7xxx driver may not
>> operate correctly in an SMP kernel with the nosmp option.  Considering
>> that your complaint about this failure came into my email box just
>> yesterday, perhaps you can give me just a few days to look into this
>> before you decide to call me unresponsive.  Since I'm attending a
>> conference this whole week, I won't even be able to look at this
>> until I return on Monday of next week.
>
> Justin, this is nothing quite serious, I just mentioned it for a feedback to
> something _simple_.

It's the only thing you've mentioned that I have enough information to
look at.

>> I'm sorry that you are experiencing data corruption.  I take those
>> issues very seriously, but all of your panics and other reports point
>> to issues elsewhere in the kernel that should be resolved before you
>> conclude that the data corruption you are experiencing is somehow
>> the aic7xxx driver's fault.  I'll be more than happy to fess up to
>> and correct any defect that is found in the driver, but I cannot fix
>> bugs that I cannot reproduce and that have no usable debugging information
>> associated with them.
>
> What exactly is "elsewhere" if your data is bogus when tar'ing onto /dev/tape
> via aic and it is completely ok when tar'ing into a file via reiserfs/3ware ?
> There is not really much left between tar and the aic-driver and the tape.

I suggest you go browse the code that is exercised by such an activity
before you say that.

--
Jusitn


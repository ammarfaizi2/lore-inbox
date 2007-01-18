Return-Path: <linux-kernel-owner+w=401wt.eu-S932588AbXARU3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbXARU3A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbXARU3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:29:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33077 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXARU27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:28:59 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45AFD862.6040903@s5r6.in-berlin.de>
Date: Thu, 18 Jan 2007 21:28:18 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
References: <je7iwa1l8a.fsf@sykes.suse.de>	<1167550089.12593.11.camel@melchior>  <jey7oowgdo.fsf@sykes.suse.de> <1167708109.12382.26.camel@melchior> <459A800E.3010604@s5r6.in-berlin.de>
In-Reply-To: <459A800E.3010604@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 2007-01-02:
> Kyuma Ohta wrote:
> ...
>> Now,I'm testing 2.6.20-rc3 for x86_64, submitted patch for this issue;
>> "Fault has happened  in 'cleanuped' sbp2/1394 module in *not 32bit*
>> architecture hardwares ."
>>
>> As result of, sbp2 driver in 2.6.20-rc3 is seems to running 
>> w/o any faults,but communication both host and harddrive(s) 
>> was seems to be unstable yet :-(
>> Sometimes confuse packets,such as *very* older 1394 driver :-(
> 
> That is, sbp2 on 2.6.20-rc3 works less stable for you than on 2.6.19? Or
> which previous kernel is the basis of your comparison? Are there any log
> messages or other diagnostics? And what hardware do you have?
> 
> If you can tell which kernel was good for you, I could create a set of
> patches for you which allows to revert sbp2 while keeping the rest of
> the kernel at the level of 2.6.20-rc3, so that you could find the
> destabilizing change (if it happened in sbp2, not somewhere else).
[...]

So, how about it? Is there an actual regression? If so, we should find
the cause and fix before 2.6.20 is released.

Note, sbp2's optional parameter serialize_io=0 does not work correctly
yet with some devices (it never did), therefore use sbp2 with anything
than default parameters if there are problems.
-- 
Stefan Richter
-=====-=-=== ---= =--=-
http://arcgraph.de/sr/

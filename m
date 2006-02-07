Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWBGG5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWBGG5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWBGG5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:57:17 -0500
Received: from mail.dvmed.net ([216.237.124.58]:55168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964914AbWBGG5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:57:16 -0500
Message-ID: <43E844C3.5080500@pobox.com>
Date: Tue, 07 Feb 2006 01:57:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: Stefan Seyfried <seife@suse.de>, Olaf Kirch <okir@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: e100 oops on resume
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home>	 <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de>	 <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>	 <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com>	 <20060126190236.GA12481@suse.de>	 <20060128115335.GA4511@inferi.kami.home> <4807377b0601281153r618586ddhca27b7772e023d26@mail.gmail.com>
In-Reply-To: <4807377b0601281153r618586ddhca27b7772e023d26@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jesse Brandeburg wrote: > On 1/28/06, Mattia Dongili
	<malattia@linux.it> wrote: > >>On Thu, Jan 26, 2006 at 08:02:37PM
	+0100, Stefan Seyfried wrote: >> >>>On Wed, Jan 25, 2006 at 04:28:48PM
	-0800, Jesse Brandeburg wrote: >>> >>> >>>>Okay I reproduced the issue
	on 2.6.15.1 (with S1 sleep) and was able >>>>to show that my patch that
	just removes e100_init_hw works okay for >>>>me. Let me know how it
	goes for you, I think this is a good fix. >>> >>>worked for me in the
	Compaq Armada e500 and reportedly also fixed the >>>SONY that
	originally uncovered it. >> >>confirmed here too. The patch fixes S3
	resume on this Sony (GR7/K) >>running 2.6.16-rc1-mm3. > > > excellent
	news! thanks for testing. > > Jeff, could you please apply to
	2.6.16-rcX > > Jesse [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> On 1/28/06, Mattia Dongili <malattia@linux.it> wrote:
> 
>>On Thu, Jan 26, 2006 at 08:02:37PM +0100, Stefan Seyfried wrote:
>>
>>>On Wed, Jan 25, 2006 at 04:28:48PM -0800, Jesse Brandeburg wrote:
>>>
>>>
>>>>Okay I reproduced the issue on 2.6.15.1 (with S1 sleep) and was able
>>>>to show that my patch that just removes e100_init_hw works okay for
>>>>me.  Let me know how it goes for you, I think this is a good fix.
>>>
>>>worked for me in the Compaq Armada e500 and reportedly also fixed the
>>>SONY that originally uncovered it.
>>
>>confirmed here too. The patch fixes S3 resume on this Sony (GR7/K)
>>running 2.6.16-rc1-mm3.
> 
> 
> excellent news! thanks for testing.
> 
> Jeff, could you please apply to 2.6.16-rcX
> 
> Jesse

SIGH.  In your last patch submission you had it right, but Intel has yet 
again regressed in patch submission form.

Your fixes will be expedited if they can be applied by script, and then 
quickly whisked upstream to Linus/Andrew.  This one had to be applied by 
hand (so yes, its applied) for several reasons:

* Unreviewable in mail reader, due to MIME type application/octet-stream.

* In general, never use MIME (attachments), they decrease the audience 
that can easily review your patch.

* Your patch's description and signed-off-by were buried inside the 
octet-stream attachment.

* Please review http://linux.yyz.us/patch-format.html  (I probably 
should add MIME admonitions to that)

	Jeff



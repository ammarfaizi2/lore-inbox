Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDDTya>; Wed, 4 Apr 2001 15:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRDDTyU>; Wed, 4 Apr 2001 15:54:20 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:55057 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S132056AbRDDTyR>; Wed, 4 Apr 2001 15:54:17 -0400
Message-ID: <3ACB6DEB.4020709@megapathdsl.net>
Date: Wed, 04 Apr 2001 11:54:35 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac2 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Dodd <ted@cypress.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to
In-Reply-To: <E14kWCc-0000EF-00@the-village.bc.nu> <3ACB7216.9F12D286@cypress.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dodd wrote:

> Alan Cox wrote:
> 
>>> David Brownell recently added this check to the usb-ohci driver
>>> since noone has gotten information from AMD for the workaround,
>>> which is rumored to exist, for this bug.
>>> 
>>> Do any of you have contacts within AMD who might be able to
>>> get an explanation of the workaround to David Brownell?
>> 
>> We are working on that currently via the Red Hat contact.
>> 
>> 
>>> value given varies.  Rereading NDP seems to give a valid value.
>>> I am not really clear why we don't simply read the value twice
>>> whenever the host-controller is detected to be an AMD-756.
>> 
>> because we dont know the full scope of the problem yet.
> 
> 
> Exactly how many bug reports has this caused?
> What kind of problems?
> 
> I know I had trouble onece, but it was a CONFIG problem
> with the 2.4.2ac series and the extra DEBUG options.

I think probably everyone who has an AMD-756 has reported
this error.  At least, I've not seen any messages from
people saying, "I have an AMD-756 and have never seen this
error."  Most of the time, when the error occurs, it seems
pretty benign.  That is, I haven't noticed it crashing USB
device connections, causing data corruption or OOPSen.
Some folks _have_ reported OOPSen, though, that seemed to
be triggered by the erratum #4 hardware bug.  I think I
may have had one of these a long time ago.

I believe David has found that there definitely are code
paths where this hardware bug can cause failures of various
sorts and that's why the AMD-756 has been blacklisted.
I don't believe these failure code paths have anything to
do with specific debugging configurations.

David/Alan, please correct me if I've got this all wrong.

Thanks,
	Miles


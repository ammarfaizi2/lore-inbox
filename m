Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUK3SCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUK3SCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUK3SAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:00:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262235AbUK3R4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:56:48 -0500
Message-ID: <41ACB434.4030100@pobox.com>
Date: Tue, 30 Nov 2004 12:56:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] move OSS ac97_codec.h to sound/oss/
References: <20041130013139.GC19821@stusta.de>	 <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk> <1101830044.25603.49.camel@localhost.localdomain>
In-Reply-To: <1101830044.25603.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2004-11-30 at 01:37, Al Viro wrote:
> 
>>On Tue, Nov 30, 2004 at 02:31:39AM +0100, Adrian Bunk wrote:
>>
>>>As far as I can see, there's no good reason why the OSS ac97_codec.h 
>>>lives in include/linux/ .
>>
>>Except for a bunch of constants defined there.  Are you sure that they
>>are not exposed to userland?
> 
> 
> OSS never really exposed raw AC97 to user space. Probably it should have
> for the whacky corner cases and for stuff like AC97 digitizers.
> 
> Acked-by: Alan Cox <alan@redhat.com>

Disagreement-from:  Jeff Garzik <jgarzik@pobox.com>


The reason why ac97_codec.h is in include/linux is because it provides a 
__public interface__.

Adrian's change

(a) makes it difficult to work on OSS drivers outside sound/oss

(b) increases the pain level of keeping 2.4 and 2.6 drivers in sync -- 
something that I am doing to i810_audio at least.

ac97_codec.h should stay where it is, until OSS drivers are removed from 
the tree.

	Jeff




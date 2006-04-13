Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWDMScl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWDMScl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWDMScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:32:41 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:4924 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750845AbWDMSck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:32:40 -0400
In-Reply-To: <20060412233032.GA28007@suse.de>
References: <443D3DED.5030009@keyaccess.nl> <20060412214108.GA12480@suse.de> <7724966D-F760-4075-8D69-B4B73700A9BA@kernel.crashing.org> <20060412233032.GA28007@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6393DBC-CB41-4F45-9474-E6CCE22486FA@kernel.crashing.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Is platform_device_register_simple() deprecated?
Date: Thu, 13 Apr 2006 13:32:33 -0500
To: Greg KH <gregkh@suse.de>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 12, 2006, at 6:30 PM, Greg KH wrote:

> On Wed, Apr 12, 2006 at 06:09:48PM -0500, Kumar Gala wrote:
>>
>> On Apr 12, 2006, at 4:41 PM, Greg KH wrote:
>>
>>> On Wed, Apr 12, 2006 at 07:50:37PM +0200, Rene Herman wrote:
>>>> Hi Greg, Russel, Dmitry.
>>>>
>>>> ALSA is using platform_device_register_simple(). Jean Delvare
>>>> pointed:
>>>>
>>>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
>>>>
>>>> out, where _simple looks to be slated for removal. Is this  
>>>> indeed the
>>>> case? ALSA isn't using the resources -- doing a manual alloc/add
>>>> would
>>>> not be a problem...
>>>
>>> Great, care to convert ALSA to use the proper api so we can remove
>>> platform_device_register_simple()?
>>
>> Can we mark this deprecated and add it to feature-removal- 
>> schedule.txt.
>
> Sure, I'll take a patch for that.  But really, it's just easier to fix
> up all callers and delete the function.  It isn't anything that
> feature-removal-schedule.txt should care about, as it's just the  
> normal
> API changes we do all the time.


Well, it is an exported interface so I figured that fit in the same  
category as removing the export of insert_resource.

But, I'm not too concerned one way or the other about it.

- k

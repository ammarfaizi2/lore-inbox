Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWHRD6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWHRD6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 23:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHRD6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 23:58:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932344AbWHRD6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 23:58:14 -0400
Message-ID: <44E68C4E.8070607@osdl.org>
Date: Fri, 18 Aug 2006 20:58:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>, xavier.bestel@free.fr, 7eggert@gmx.de,
       cate@debian.org, 7eggert@elstempel.de, shemminger@osdl.org,
       mitch.a.williams@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
References: <20060816133811.GA26471@nostromo.devel.redhat.com> <Pine.LNX.4.58.0608161636250.2044@be1.lrz> <1155799783.7566.5.camel@capoeira> <20060817.162340.74748342.davem@davemloft.net> <20060818022057.GA27076@nostromo.devel.redhat.com>
In-Reply-To: <20060818022057.GA27076@nostromo.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham wrote:
> David Miller (davem@davemloft.net) said: 
>   
>> From: Xavier Bestel <xavier.bestel@free.fr>
>> Date: Thu, 17 Aug 2006 09:29:43 +0200
>>
>>     
>>> Why not simply retricting chars to isalnum() ones ?
>>>       
>> As Bill said that would block things like "-" and "_" which are fine.
>>
>> Bill also mentioned something about "breaking configs going back to
>> 2.4.x" which is bogus because nothing broke when we started blocking
>> "/" and "." and ".." in networking device names during the addition of
>> sysfs support for net devices.
>>     
>
> I was mainly referring to if we started to filter it out to isalnum() -
> spaces/tab/CR etc. certainly could be filtered. (No idea what would
> happen with unicode nbsp or other silly things.)
>
> Bill
>   
How just restrictiting to !isspace()


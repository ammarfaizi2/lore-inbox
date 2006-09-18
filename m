Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWIRWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWIRWJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWIRWJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:09:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:26499 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030200AbWIRWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:09:33 -0400
Date: Mon, 18 Sep 2006 14:57:04 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>, Andi Kleen <ak@suse.de>,
       Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
In-Reply-To: <20060918220038.GB14322@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.63.0609181452470.14338@qynat.qvtvafvgr.pbz>
References: <4492D5D3.4000303@atmos.washington.edu>  <200609181754.37623.ak@suse.de>
 <20060918162847.GA4863@ms2.inr.ac.ru>  <200609181850.22851.ak@suse.de> 
 <20060918211759.GB31746@tentacle.sectorb.msk.ru> <20060918220038.GB14322@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Alexey Kuznetsov wrote:

> Hello!
>
>> Please think about it this way:
>> suppose you haave a heavily loaded router and some network problem is to
>> be diagnosed. You run tcpdump and suddenly router becomes overloaded (by
>> switching to timestamp-it-all mode
>
> I am sorry. I cannot think that way. :-)
>
> Instead of attempts to scare, better resend original report,
> where you said how much performance degraded, I cannot find it.
>
> * I do see get_offset_pmtmr() in top lines of profile. That's scary enough.
> * I do not undestand what the hell dhcp needs timestamps for.
> * I do not listen any suggestions to screw up tcpdump with a sysctl.
>  Kernel already implements much better thing then a sysctl.
>  Do not want timestamps? Fix tcpdump, add an options, submit the
>  patch to tcpdump maintainers. Not a big deal.

if fireing up one program (however minor) can cause network performance to drop 
by >50% (based on the numbers reported earlier in this thread) that is a 
significant problem for sysadmins.

yes tcpdump may be wrong in requesting timestamps (in most cases it probably is, 
but in some cases it's doing exactly what the sysadmin wants it to do), but I 
don't think that many sysadmins would expect this much of a performance hit. 
there should be some way to tell the system to ignore requests for timestamps so 
that a badly behaved program cannot cripple the system this way (and preferably 
something that doesn't require a full SELinux/capabilities implementation)

David Lang

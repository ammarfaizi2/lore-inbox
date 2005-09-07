Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVIGRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVIGRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGRf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:35:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42477 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750989AbVIGRf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:35:56 -0400
Message-ID: <431F24A5.2080703@us.ibm.com>
Date: Wed, 07 Sep 2005 13:34:29 -0400
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 0/3] New system call, unshare
References: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM> <878xz9dgv4.fsf@mid.deneb.enyo.de> <20050823061815.GE9322@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050823061815.GE9322@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Aug 10, 2005 at 04:08:31PM +0200, Florian Weimer wrote:
> 
>>* Janak Desai:
>>
>>
>>>With unshare, namespace setup can be done using PAM session
>>>management functions without patching individual commands.
>>
>>I don't think it's a good idea to use security-critical code well
>>without its original specification.  Clearly the current situation
>>sucks, but this is mainly a lack of PAM functionality, IMHO.
> 
> 
> Eh?  We are talking about a primitive that has far more uses than
> PAM.  This is a missing piece of the stuff done by clone() and fork():
> each task is a virtual machine with sharable components.  We can
> get a copy of machine  with arbitrary set of components replaced with
> private copies.  That's what clone() and fork() do.  The thing missing
> from that set is taking a component (VM, descriptors, etc.) of process
> itself and making it private.  The same thing we do on fork(), but
> without creating a new process.
> 
> FWIW, I'm OK with that.  IIRC, Linus ACKed the concept some time ago.
> PAM is one obvious use, but there's are other situations where the lack
> of that primitive is inconvenient...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks. In a few minutes, I will submit versions of these patches
that are ported and tested against 2.6.13-mm1.

-Janak



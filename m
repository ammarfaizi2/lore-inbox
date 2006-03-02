Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWCBVxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWCBVxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWCBVxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:53:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:62889 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750864AbWCBVxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:53:19 -0500
Message-ID: <4407693E.6000108@vilain.net>
Date: Fri, 03 Mar 2006 10:53:02 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation
 [try #2]]
References: <44074CFD.7050708@vilain.net>  <20060302084448.GA21902@infradead.org> <440613FF.4040807@vilain.net> <3254.1141299348@warthog.cambridge.redhat.com> <5923.1141333943@warthog.cambridge.redhat.com>
In-Reply-To: <5923.1141333943@warthog.cambridge.redhat.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>>AIUI, each patch must stand on its own in every regard.  I guess you 
>>need to make it inline in the later patch - or not at all given the 
>>marginal speed difference vs. core size increase.
>>    
>>
>
>No. It has to be permissable to make a series of patches that depend one upon
>another for at least three reasons:
>
> (1) Patches can be unmanageably large in one lump, so splitting them up is a
>     sensible option, even through the individual patches won't work or even
>     compile independently.
>
> (2) It may make sense to place linked changes to two logically separate units
>     in two separate patches, for instance I'm changing the core kernel to add
>     an extra argument to get_sb() and the get_sb_*() convenience functions in
>     one patch and then supplying another patch to change all the filesystems.
>
>     This makes it much easier for a reviewer to see what's going on. They know
>     the patches are interdependent, but they can see the main core of the
>     changes separated out from the massively repetative but basically less
>     interesting changes that are a side effect of the main change.
>
> (3) A series of patches may form a set of logical steps (for instance my
>     patches 1-2 are the first step and patches 3-5 the second). It may be (and
>     it is in my case) that each step will build and run, provided all the
>     previous steps are applied; but that a step won't build or run without the
>     preceding steps.
>
>Remember: one of the main reasons for splitting patches is to make it easier
>for other people to appreciate just how sublimely terrific your work is:-)
>  
>

Interesting.  I've just seen patches slammed by subsystem maintainers 
before for doing things "the wrong way around" within a patchset.

I don't remember seeing this covered in TPP, am I missing having read a 
guide document or is this grey area?

Sam.


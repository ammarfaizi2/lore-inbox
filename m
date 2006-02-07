Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWBGOdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWBGOdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWBGOdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:33:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48268 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965099AbWBGOdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:33:39 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E889B6.5030002@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 07:31:33 -0700
In-Reply-To: <43E889B6.5030002@sw.ru> (Kirill Korotaev's message of "Tue, 07
 Feb 2006 14:51:18 +0300")
Message-ID: <m164nrgrzu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>> We are never going to form a consensus if all of the people doing
>>>> implementations don't talk.
>>>
>>> Speaking of which - it would be interesting to get Kirill's
>>> comments on Eric's patchset ;)
> I'll do comment.

Thank you I will look forward to your comments.

>>> Once we know what's good and bad about both patchsets, we'll
>>> be a lot closer to knowing what exactly should go upstream.
> I'm starting to think that nothing in upstream can be better for all of us :)

In a thread voicing the concerns for maintaining out of tree patches
that is a natural concern.  

>> Let's compare approaches of patchsets before the patchsets themselves.
>> It seems to be, should we:
>>   A) make a general form of virtualising PIDs, and hope this assists
>>      later virtualisation efforts (Eric's patch)
>>   B) make a general form of containers/jails/vservers/vpses, and layer
>>      PID virtualisation on top of it somewhere (as in openvz, vserver)
>  >
>> I can't think of any real use cases where you would specifically want A)
>> without B).
> Exactly! All these patches for A) look weird for me without containers itself. A
> try to make half-solution which is bad.

I am willing to contend that my approach also leads to a complete solution.
In fact I believe my network virtualization has actually gone much farther
than yours.   Although I admit there is still some work to do before
the code is in shape to be merged.

You notice in the kernel there is also not a struct process?

To me having a container structure while an obvious approach to the problem
seems to add unnecessary policy to the kernel.  Lumping together the
implementation of multiple instances of different namespaces in a way
that the implementation does not require.

Eric

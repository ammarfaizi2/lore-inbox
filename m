Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWBHVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWBHVGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWBHVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:06:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14752 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964910AbWBHVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:06:34 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Hubertus Franke <frankeh@watson.ibm.com>,
       Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<43EA1008.5040502@sw.ru>
	<1139431435.9452.45.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 14:04:14 -0700
In-Reply-To: <1139431435.9452.45.camel@localhost.localdomain> (Dave Hansen's
 message of "Wed, 08 Feb 2006 12:43:55 -0800")
Message-ID: <m1oe1h5zqp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2006-02-08 at 18:36 +0300, Kirill Korotaev wrote: 
>> - full isolation can be inconvinient from containers management point of 
>> view. You will need to introduce new modified tools such as top/ps/kill 
>> and many many others. You won't be able to strace/gdb processes from the 
>> host also. 
>
> I'd like to put a theory out there:  the more isolation we perform, the
> easier checkpointing and migration become to guarantee.
>
> Agree?  Disagree?

Agree.  But that does not address the reasons OpenVZ and Vserver exist.

> But, full isolation is hard to code.  

Disagree.  If you limit your self to just changing the code that
translates from names to objects it is a very narrow slice of code,
and there are very few surprises.  There is a lot of grunt work involved
but it easy to tell if you got everything and did it correctly.

Other approaches are more adhoc, take short cuts, and seem prone to missing
the corner cases.

> The right approach is very likely
> somewhere in the middle where we require some things to happen
> underneath us.  For instance, requiring that the filesystem be made
> consistent if a container is moved across systems.

Possibly.  That is very out from where we are at the moment.
Let's get the isolation and see where we are at.

Eric


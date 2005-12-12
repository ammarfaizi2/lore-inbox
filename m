Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVLLO4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVLLO4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLLO4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:56:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64924 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751252AbVLLO4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:56:47 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: schwab@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org, pj@sgi.com,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common
 code
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
	<m1pso29z37.fsf@ebiederm.dsl.xmission.com>
	<E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu>
	<jepso2752o.fsf@sykes.suse.de>
	<E1Elox7-0005lf-00@dorka.pomaz.szeredi.hu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 12 Dec 2005 07:54:52 -0700
In-Reply-To: <E1Elox7-0005lf-00@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
 message of "Mon, 12 Dec 2005 15:46:57 +0100")
Message-ID: <m1ek4i9xhf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

>> >> Does powerpc still build?  A key question is how do we handle architectures
>> >> that always want to want to call machine_power_off.
>> >
>> > I didn't (and can't) check, but it should.  IIRC multiple declaration
>> > of a variable is OK, as long as at most one has an initializer.
>> 
>> And as long as you don't build with -fno-common.
>
> That seals the argument, since -fno-common is in linux/Makefile.
>
> So the patch wants fixing on powerpc, but I don't feel up to the task.
>
> Somebody with better knowledge of that arch?

It isn't just powerpc, alpha at least wants this behavior as well.

So until someone comes up with something better I am going to recommend
we fix the arches one at a time so we can actually audit them and
see what needs doing.

Eric

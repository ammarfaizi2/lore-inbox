Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWFHT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWFHT5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWFHT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:57:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61336 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964955AbWFHT5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:57:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Dave Hansen <haveblue@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: 2.6.18 -mm merge plans
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605144328.GA12904@sergelap.austin.ibm.com>
Date: Thu, 08 Jun 2006 13:56:42 -0600
In-Reply-To: <20060605144328.GA12904@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Mon, 5 Jun 2006 09:43:29 -0500")
Message-ID: <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Andrew Morton (akpm@osdl.org):
>> proc-sysctl-add-_proc_do_string-helper.patch
>> namespaces-add-nsproxy.patch
>> namespaces-add-nsproxy-dont-include-compileh.patch
>> namespaces-incorporate-fs-namespace-into-nsproxy.patch
>> namespaces-utsname-introduce-temporary-helpers.patch
>> namespaces-utsname-switch-to-using-uts-namespaces.patch
>> namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
>> namespaces-utsname-switch-to-using-uts-namespaces-cleanup.patch
>> namespaces-utsname-use-init_utsname-when-appropriate.patch
>> namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch
>> namespaces-utsname-implement-utsname-namespaces.patch
>> namespaces-utsname-implement-utsname-namespaces-export.patch
>> namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
>> namespaces-utsname-sysctl-hack.patch
>> namespaces-utsname-sysctl-hack-cleanup.patch
>> namespaces-utsname-sysctl-hack-cleanup-2.patch
>> namespaces-utsname-sysctl-hack-cleanup-2-fix.patch
>> namespaces-utsname-remove-system_utsname.patch
>> namespaces-utsname-implement-clone_newuts-flag.patch
>> uts-copy-nsproxy-only-when-needed.patch
>> # needed if git-klibc isn't there:
>> #namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
>> #namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
>> #namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch
>> 
>>  utsname virtualisation.  This doesn't seem very pointful as a standalone
>>  thing.  That's a general problem with infrastructural work for a very
>>  large new feature.
>> 
>>  So probably I'll continue to babysit these patches, unless someone can
>>  identify a decent reason why mainline needs this work.
>> 
>>  I don't want to carry an ever-growing stream of OS-virtualisation
>>  groundwork patches for ever and ever so if we're going to do this thing...
>>  faster, please.

Ack.  I agree we need to start moving faster.
I had a couple of distractions but I should be sending out some
relevant patches in a bit.  The more we can get out for review
before kernel summit the better the conversation will be I suspect.

> Eric, Kirill, Dave, Hubertus,
>
> In the spirit of 'faster, please', does someone care to port and
> resubmit a pidspace patch?

I think I can get that one. Except for the very tail end though
most of my patches probably won't be directly pidspace patches.
I'm going to work on killing sys_sysctl a little before I
get to far into that.   A pidspace is one of the most controversial
patches so it is a bit tricky.

> I'll do it if noone else wants to, just don't want to step on anyone's
> toes if you were already working on it.

If you want to help with the bare pid to struct pid conversion I
don't have any outstanding patches, and getting that done kills
some theoretical pid wrap around problems as well as laying the ground
work for a simple pidspace implementation.

Eric

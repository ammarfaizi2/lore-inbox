Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425270AbWLHJIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425270AbWLHJIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425273AbWLHJIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:08:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38070 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425270AbWLHJIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:08:35 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	<m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
	<86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
Date: Fri, 08 Dec 2006 02:07:53 -0700
In-Reply-To: <86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
	(Yinghai Lu's message of "Fri, 8 Dec 2006 00:53:53 -0800")
Message-ID: <m1zm9y3gd2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 12/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Ugh.  I'd check the code.  But it looks like my tweak to the
>> early fixmap code.  But my hunch is that my tweak to __fixmap
>> so that it's pud and pmd were prepopulated didn't take on
>> your build.
>
> I missed some options?

Your or I missed a bug fix/enhancement in there somewhere.

Basically my very early setup of the fixmap failed.
Now.  I thought I had that covered by preallocated the pud and the pmd
entries.   So the only thing missing was the pte entries.

If that is not a big enough hint I will look into it in a bit...

I'm starting to become a big fan of constant initializers.  So our
core subsystems don't need initialization code to be useful.  All of
these early things are just a pain.

Eric

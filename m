Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVLFSrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVLFSrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVLFSrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:47:15 -0500
Received: from mail.suse.de ([195.135.220.2]:8603 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965012AbVLFSrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:47:14 -0500
Date: Tue, 6 Dec 2005 19:47:08 +0100
From: Andi Kleen <ak@suse.de>
To: Avuton Olrich <avuton@gmail.com>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: Machine check exception
Message-ID: <20051206184708.GV11190@wotan.suse.de>
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com> <1132406652.5238.19.camel@localhost.localdomain> <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com> <1132436886.19692.17.camel@localhost.localdomain> <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com> <p73y82yqaaf.fsf@verdi.suse.de> <3aa654a40512061045h33fea2a0y1511366df2e7c166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a40512061045h33fea2a0y1511366df2e7c166@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 10:45:36AM -0800, Avuton Olrich wrote:
> On 06 Dec 2005 12:45:44 -0700, Andi Kleen <ak@suse.de> wrote:
> > ebiederm@xmission.com (Eric W. Biederman) writes:
> > >
> > > To decode an Opteron machine_check you can look in
> > > the bios and kernel programmers guide.  (Possibly the
> 
> > mcelog --ascii decodes the "final" machine checks output
> > by the 64bit kernel. The normal recoverable machine checks
> > should be decoded at runtime assuming your distribution
> > set it up right (normally into /var/log/mcelog)
> 
> That also works on kernel panic?

The automatic logging doesn't work during panic, but if you 
redirected the output of the kernel panic to some other machine
(using serial console etc) you can pipe that log 
into it for decoding.

-Andi

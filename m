Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275064AbTHGBge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275065AbTHGBgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:36:33 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:58019 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S275064AbTHGBgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:36:32 -0400
Date: Thu, 7 Aug 2003 02:34:34 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, kwijibo@zianet.com
Subject: Re: Machine check expection panic
Message-ID: <20030807013434.GA17498@suse.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	richard.brunner@amd.com, linux-kernel@vger.kernel.org,
	kwijibo@zianet.com
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel> <20030807002722.GA3579@suse.de.suse.lists.linux.kernel> <p73ekzynuxt.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ekzynuxt.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 03:00:14AM +0200, Andi Kleen wrote:

 > The change looks rather suspicious to me.

It's been in 2.4 for months, it solved the same problem there as
many people are now seeing in 2.6.  The "I don't get MCEs in 2.4
but I get them in 2.6" reports are numerous, and I don't buy the
"2.6 stresses hardware more" theory for a second.
 
 > Bank 0 is the data cache unit (DC)
 > Do you have an errata that says that the DC bank is bad on all Athlons?

Hmm, I thought this was actually documented, but I can't seem to find
it in any of the docs I have. There are however gaps between the
errata numbers in a few cases, so its possible it was removed in
a later version of the revision guide.  Richard ?
 
 > Normally BIOS or microcode are supposed to turn off bad MCEs by 
 > masking them in another register. Maybe the person's CPU has a 
 > real problem that is just masked now, e.g. it could be overclocked
 > and stress the cache too much.

I recall seeing Athlon owners complain when I 'fixed' this problem
using an inverse of this patch in 2.4.19-pre3. For pre4, Marcelo
backed it out, and people were happy again.

Whether its documented or not, there are boxes out there that don't
like having that bank enabled.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWCFRww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWCFRww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWCFRww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:52:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751960AbWCFRwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:52:51 -0500
Date: Mon, 6 Mar 2006 12:52:38 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060306175238.GA15971@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <20060306125018.GA1673@elf.ucw.cz> <20060306171747.GN21445@redhat.com> <20060306174122.GA2716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306174122.GA2716@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 06:41:22PM +0100, Pavel Machek wrote:

 > >  > Is adding "noapic nolapic" to default command line a big problem?
 > > For end-users, yes.  People want things to 'just work', not have
 > > to find arcane commands to type in to make things work.
 > If distro puts "noapic nolapic" on kernel command line, I'd say users
 > are unlikely to remove it.. And if they do remove it and it breaks,
 > they'll only blame themselves...

If distros put 'noapic nolapic' on the command line they've only
themselves to blame when systems that need local apic for
correct operation don't work.

 > One more config-option is also not "cheap" (half of users will get it
 > wrong), and having config-option to change command-line-default seems
 > wrong to me.
 >
 > [Well, you could add CONFIG_CMDLINE to i386, like arm has... that
 > solves more than just this problem...]

I'm not arguing for extra command line options. The inverse, I want
*no* command line options.

What's so hard to understand about expecting something to just work?

		Dave

-- 
http://www.codemonkey.org.uk

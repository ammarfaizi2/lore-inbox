Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291789AbSBNRFg>; Thu, 14 Feb 2002 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291793AbSBNRF0>; Thu, 14 Feb 2002 12:05:26 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:24724 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S291789AbSBNRFI>; Thu, 14 Feb 2002 12:05:08 -0500
Date: Thu, 14 Feb 2002 18:05:07 +0100
From: bert hubert <ahu@ds9a.nl>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, torvalds@transmeta.com
Subject: Re: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <20020214180507.A18665@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org,
	drepper@redhat.com, torvalds@transmeta.com
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl> <38300000.1013702447@baldur> <20020214170748.B17490@outpost.ds9a.nl> <46860000.1013703583@baldur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <46860000.1013703583@baldur>; from dmccr@us.ibm.com on Thu, Feb 14, 2002 at 04:21:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 04:21:52PM +0000, Dave McCracken wrote:

> The only workaround I can think of is, as you discovered, to do the
> setuid() call before you create any threads, and thus create underlying
> kernel tasks.  Once the kernel tasks have been created each one has its own
> credentials and has to be changed separately.

I'm wondering what the right semantics are. POSIX is one thing, but having
the ability to have threads with different uids in one VM would have its
uses too.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc

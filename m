Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291791AbSBNROr>; Thu, 14 Feb 2002 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291794AbSBNROh>; Thu, 14 Feb 2002 12:14:37 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:25314 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291791AbSBNRO3>; Thu, 14 Feb 2002 12:14:29 -0500
Date: Thu, 14 Feb 2002 11:14:24 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com, torvalds@transmeta.com
Subject: Re: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <66390000.1013706864@baldur>
In-Reply-To: <20020214180507.A18665@outpost.ds9a.nl>
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl>
 <38300000.1013702447@baldur> <20020214170748.B17490@outpost.ds9a.nl>
 <46860000.1013703583@baldur> <20020214180507.A18665@outpost.ds9a.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 14, 2002 18:05:07 +0100 bert hubert <ahu@ds9a.nl>
wrote:

> I'm wondering what the right semantics are. POSIX is one thing, but having
> the ability to have threads with different uids in one VM would have its
> uses too.

That's the idea behind the patch I've been working on.  It would be an
option to clone(), just like sharing address space, signals, and files.
The pthread libraries could turn it on for POSIX behavior, and programs
that wanted something different could call clone() with their own flags.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


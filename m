Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSG1Ays>; Sat, 27 Jul 2002 20:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318871AbSG1Ays>; Sat, 27 Jul 2002 20:54:48 -0400
Received: from holomorphy.com ([66.224.33.161]:8869 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318868AbSG1Ays>;
	Sat, 27 Jul 2002 20:54:48 -0400
Date: Sat, 27 Jul 2002 17:57:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
Message-ID: <20020728005722.GR25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>,
	Russell Lewis <spamhole-2001-07-16@deming-os.org>,
	linux-kernel@vger.kernel.org
References: <3D418DFD.8000007@deming-os.org> <E17Yc6Q-0001yA-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E17Yc6Q-0001yA-00@starship>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 02:40:05AM +0200, Daniel Phillips wrote:
> There are two elephants in the bathtub: the mem_map array, which holds a few 
> bytes of state information for each physical page in the system, and page 
> tables, neither of which are swapped or pruned in any way.  We are now 
> beginning to suffer pretty badly because of this, on certain high end 
> configurations.  The problem is, these structures have to keep track of much 
> more than just the kernel memory.  The former has to have entries for all of 
> the high memory pages (not addressable within the kernel's normal virtual 
> address space) and the latter has to keep track of pages mapped into every 
> task in the system, in other words, a virtually unlimited amount of memory 
> (pun intended).  Solutions are being pursued.  Paging page tables to swap is 
> one of the solutions being considered, though nobody has gone so far as to 
> try it yet.  An easier solution is to place page tables in high memory, and a 
> patch for this exists.  There is also work being done on page table sharing.

sizeof(mem_map) is a crippling issue for 32-bit machines. Something needs
to be done and fast, but it looks like most of the programmer resources
that would otherwise be there to attack the issue are tied up with even
more severe problems preventing even smaller machines from working well.
Hopefully those can be dealt with swiftly enough before Halloween.

Cheers,
Bill

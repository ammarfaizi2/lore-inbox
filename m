Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318095AbSFTCIo>; Wed, 19 Jun 2002 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318096AbSFTCIo>; Wed, 19 Jun 2002 22:08:44 -0400
Received: from holomorphy.com ([66.224.33.161]:35772 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318095AbSFTCIi>;
	Wed, 19 Jun 2002 22:08:38 -0400
Date: Wed, 19 Jun 2002 19:08:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: marc.miller@amd.com
Cc: devnull@adc.idt.com, linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
Message-ID: <20020620020809.GS22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	marc.miller@amd.com, devnull@adc.idt.com,
	linux-kernel@vger.kernel.org
References: <858788618A93D111B45900805F85267A062BB49D@caexmta3.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <858788618A93D111B45900805F85267A062BB49D@caexmta3.amd.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 07:01:08PM -0700, marc.miller@amd.com wrote:
> Support of 4G of RAM is a configuration option when you compile the
> kernel.  Is that setting turned on?  
> I think it's in "General Options" when you do a "make menuconfig"
> (I don't have a machine up at the moment that I can check).  There
> are three options:  Less than 1G, 1G to less than 4G, and 4G or more.
> That last option is the one you would want.  
> If that's already enabled, hopefully one of the memory guys can pitch in...

This is actually yet another "32-bit virtualspace sucks" issue. You can't
get at all your RAM from userspace because the virtualspace set aside for
the kernel prevents you from using it to map physical memory. 64-bit
virtualspace is too vast to be easily exhausted this way.

The original form of highmem was "BIGMEM" which used (almost) disjoint
user and kernel virtual address spaces, but this is not terribly
efficient with respect to lazy TLB entry invalidation.


Cheers,
Bill

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSDRPwh>; Thu, 18 Apr 2002 11:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSDRPwg>; Thu, 18 Apr 2002 11:52:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314379AbSDRPwg>; Thu, 18 Apr 2002 11:52:36 -0400
Date: Thu, 18 Apr 2002 16:52:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020418165229.A16156@flint.arm.linux.org.uk>
In-Reply-To: <15550.50131.489249.256007@nanango.paulus.ozlabs.org> <3112.1019144339@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 01:38:59AM +1000, Keith Owens wrote:
> For example, arm #defines get8_unaligned_check which uses __ex_table.

This doesn't cause your issue though.  Its only used from code built into
the kernel .text segment, never from any other segment.  It isn't a
#define in some random header file that may end up in the .init segment
either.

So this instance doesn't fit your problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290724AbSAYQun>; Fri, 25 Jan 2002 11:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290723AbSAYQud>; Fri, 25 Jan 2002 11:50:33 -0500
Received: from [24.64.71.161] ([24.64.71.161]:15350 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S290721AbSAYQuV>;
	Fri, 25 Jan 2002 11:50:21 -0500
Date: Fri, 25 Jan 2002 09:45:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <20020125094555.P763@lynx.adilger.int>
Mail-Followup-To: simon@baydel.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C50FBAE.26883.8EF8C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C50FBAE.26883.8EF8C@localhost>; from simon@baydel.com on Fri, Jan 25, 2002 at 06:31:10AM -0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2002  06:31 -0000, simon@baydel.com wrote:
> I am writing a module and would like to perform arithmetic on long 
> long variables. When I try to do this the module does not load due
> to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> are normally defined in libc. Is there any way I can do this in a 
> kernel module.

Normally you do not need to do 64-bit arithmetic in the kernel.  You
normally use power-of-2 values, and then shift/mask to get the results
you want.

What is it exactly that you need to do?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


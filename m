Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKTP4T>; Wed, 20 Nov 2002 10:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKTP4T>; Wed, 20 Nov 2002 10:56:19 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:62086 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261460AbSKTP4R>; Wed, 20 Nov 2002 10:56:17 -0500
Date: Wed, 20 Nov 2002 08:03:00 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021120160259.GW806@nic1-pc.us.oracle.com>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:09:18PM +1100, Neil Brown wrote:
> The interpretation of the 'name' field would be up to the user-space
> tools and the system administrator.
> I imagine having something like:
> 	host:name
> where if "host" isn't the current host name, auto-assembly is not
> tried, and if "host" is the current host name then:
>   if "name" looks like "md[0-9]*" then the array is assembled as that
>     device
>   else the array is assembled as /dev/mdN for some large, unused N,
>     and a symlink is created from /dev/md/name to /dev/mdN
> If the "host" part is empty or non-existant, then the array would be
> assembled no-matter what the hostname is.  This would be important
> e.g. for assembling the device that stores the root filesystem, as we
> may not know the host name until after the root filesystem were loaded.

	Hmm, what is the intended future interaction of DM and MD?  Two
ways at the same problem?  Just curious.
	Assuming MD as a continually used feature, the "name" bits above
seem to be preparing to support multiple shared users of the array.  If
that is the case, shouldn't the superblock contain everything needed for
"clustered" operation?

Joel

-- 

"When I am working on a problem I never think about beauty. I
 only think about how to solve the problem. But when I have finished, if
 the solution is not beautiful, I know it is wrong."
         - Buckminster Fuller

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

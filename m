Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291662AbSBHROA>; Fri, 8 Feb 2002 12:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291659AbSBHRNv>; Fri, 8 Feb 2002 12:13:51 -0500
Received: from www.casdn.neu.edu ([155.33.251.101]:38661 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S291661AbSBHRNj>; Fri, 8 Feb 2002 12:13:39 -0500
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: Greg Boyce <gboyce@rakis.net>, linux-kernel@vger.kernel.org
Date: Fri, 8 Feb 2002 12:13:23 -0500
MIME-Version: 1.0
Subject: Re: Machines misreporting Bogomips
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3C63C0E3.17319.A2A062@localhost>
In-Reply-To: <Pine.LNX.4.42.0201311747560.24180-100000@egg>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2002 at 17:55, Greg Boyce wrote:

> kernel folk,
> 
> I've got a strange issue that I've been struggling to find the solution to
> for some time now.
> 
> I work in a group that assists in the managing of large numbers of
> deployed linux boxes running variants of the 2.2 kernel on them.  The
> machines themselves are all pretty standard.  There are slight variances
> on vendors, cpu speeds, etc., but they're all running from the same
> motherboards.
> 
> Every once in a while we come across single machines which are running a
> lot slower than they should be, and are misreporting their speed in
> bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> of the kernel don't appear to affect the machines themselves at all.
> 
> I was wondering if anyone would be able to provide me with a starting
> point to hunt this down.  The only solution we had found in the past was
> to replace the machines, but some of them are located out of the country
> and that would be expensive.

It seems to me that there was an issue with timers not being set up 
properly, or changing their settings during startup, which could cause a 
machine to behave like it was running slow.  On more recent 2.2.x kernels 
you would see a line like 'timer configuration lost' in dmesg, which meant 
that the computer had the problem, and a workaround was being implimented. 

On kernels that didn't detect the timer problem you could sometimes boot 
with no problem, but other times you'd get a kernel that seemed to run very 
slowly.

I don't remember if it affected the bogomips reporting, but I would think 
that it could.

BTW, I think that the kernels I had the problems with were pre 2.2.17, 
though I'm not positive. 2.2.20 and 2.2.19 do not exhibit the problem. i.e. 
they detect the problem and work around it.




                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/


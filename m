Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbREOBEE>; Mon, 14 May 2001 21:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbREOBDy>; Mon, 14 May 2001 21:03:54 -0400
Received: from intranet.resilience.com ([209.245.157.33]:1265 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262594AbREOBDn>; Mon, 14 May 2001 21:03:43 -0400
Message-ID: <3B008169.6A6F46E@resilience.com>
Date: Mon, 14 May 2001 18:07:53 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Wayne Whitney <whitney@math.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <Pine.LNX.4.33.0105142143190.18102-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 14 May 2001, Jeff Golds wrote:
> 
> > Ahh, it's totally obvious.  1 GB option = 890 MB, 4 GB option =
> > 4GB.  Can I assume a linear relation and get 66.2 MB when I
> > select the 64 MB option?
> 
> Where did you get the mythical "1GB" option?
> 
> Last I looked we had "off", "4GB" and "64GB" ;)
> 

Good try, except:

If you are compiling a kernel which will never run on a machine with
more than 1 Gigabyte total physical RAM, answer "off" here (default
choice and suitable for most users). This will result in a "3GB/1GB"
split: 3GB are mapped so that each process sees a 3GB virtual memory  
space and the remaining part of the 4GB virtual memory space is used
by the kernel to permanently map as much physical memory as
possible.

If the machine has between 1 and 4 Gigabytes physical RAM, then
answer "4GB" here.



1 GB is not more than 1 GB so "off" is the correct choice, according to the docs.

Oh I get it NOW.  "Off" means the docs are just plain "off".

-Jeff


-- 
Jeff Golds
jgolds@resilience.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSLPRfy>; Mon, 16 Dec 2002 12:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSLPRfy>; Mon, 16 Dec 2002 12:35:54 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:13049 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S266854AbSLPRfx>; Mon, 16 Dec 2002 12:35:53 -0500
Date: Mon, 16 Dec 2002 12:43:49 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Matt Simonsen <matt_lists@careercast.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS/Top broken - /proc entry bad
Message-ID: <20021216124349.D28757@redhat.com>
References: <1039643391.27406.41.camel@mattsworkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039643391.27406.41.camel@mattsworkstation>; from matt_lists@careercast.com on Wed, Dec 11, 2002 at 01:49:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysreq-t to get a backtrace of the processes.  Most likely one of 
them hung while still holding the mm semaphore, thereby preventing ps 
and top from proceeding.  Check your log for oopsen.

		-ben

On Wed, Dec 11, 2002 at 01:49:51PM -0800, Matt Simonsen wrote:
> I had a box where ps and top quit working after hundreds of days uptime.
> After doing an strace ps I found that one directory in /proc was hanging
> it up, a directory named a 5 digit number which I believe was
> associtated with a process of the same name.
> 
> I tried doing a kill -9 on the process, it returned fine but the process
> was still there. Reboot hung my session, too, I had to use reboot -f to
> get the machine healthy again.
> 
> Is there any way to "fix" /proc other than what I did? I suppose maybe
> going into a lower init level and then back to 3 may have worked. It's a
> remote machine, though, so reboot was at the time seemed like a better
> solution.
> 
> Any comments/suggestions on what to do in this situation?
> 
> Thanks
> Matt
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"Do you seek knowledge in time travel?"

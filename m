Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSDSR1H>; Fri, 19 Apr 2002 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDSR1G>; Fri, 19 Apr 2002 13:27:06 -0400
Received: from rgminet1.oracle.com ([148.87.122.30]:17365 "EHLO
	rgminet1.oracle.com") by vger.kernel.org with ESMTP
	id <S312601AbSDSR1F>; Fri, 19 Apr 2002 13:27:05 -0400
Date: Fri, 19 Apr 2002 10:26:56 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updated Watchdog Updates
Message-ID: <20020419172655.GA862@insight.us.oracle.com>
In-Reply-To: <Pine.LNX.4.33.0204190959500.17511-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 10:01:15AM -0400, Rob Radez wrote:
> I just put up http://osinvestor.com/wd-2.4.19-pre7-7.diff and
> http://osinvestor.com/wd-2.4.19-pre7-ac1-1.diff

Rob,
	Here's an edit on the WDIOC_SETTIMEOUT ioctl:

WDIOC_SETTIMEOUT:
	If the watchdog has a configurable timeout, then this is how and
	where it gets set (other than module load or kernel command line).
	The passed argument is the new timeout in seconds.  Watchdogs
	with a granularity that does not allow the new timeout must set
	the timeout to the next greater allowable timeout.  The watchdog
	must never fire in less than the passed timeout.  After setting 
	the new timeout, the ioctl copies the actual timeout in seconds
        back to userspace.  This allows userspace to know what the
	timeout really is.

Thanks,
Joel

-- 

Life's Little Instruction Book #306

	"Take a nap on Sunday afternoons."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135272AbRASQrD>; Fri, 19 Jan 2001 11:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135329AbRASQqy>; Fri, 19 Jan 2001 11:46:54 -0500
Received: from Cantor.suse.de ([194.112.123.193]:41227 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135272AbRASQqp>;
	Fri, 19 Jan 2001 11:46:45 -0500
Date: Fri, 19 Jan 2001 17:46:08 +0100
From: Andi Kleen <ak@suse.de>
To: "Ian S. Nelson" <ian.nelson@echostar.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How come top and /proc/meminfo on 2.4.0 says 0K shared?
Message-ID: <20010119174608.A22956@gruyere.muc.suse.de>
In-Reply-To: <3A686DB1.8096DA0D@echostar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A686DB1.8096DA0D@echostar.com>; from ian.nelson@echostar.com on Fri, Jan 19, 2001 at 09:39:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 09:39:13AM -0700, Ian S. Nelson wrote:
> is this a bug?
> 
> We have a number of machines running 2.4.0 and /proc/meminfo says we're
> sharing no memory.  top says that also, probably because it just reads
> /proc/meminfo, or at least I assume that's how it works.    All the
> individual procs show the memory they are sharing though.

It has been removed because the computation involved walking the complete
memory maps and it caused noticeable scheduling hickups (mouse pointer hangs etc.)
on big memory machines.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

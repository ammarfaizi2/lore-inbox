Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUDQVxB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 17:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUDQVxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 17:53:00 -0400
Received: from florence.buici.com ([206.124.142.26]:10368 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264058AbUDQVw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 17:52:59 -0400
Date: Sat, 17 Apr 2004 14:52:57 -0700
From: Marc Singer <elf@buici.com>
To: William Lee Irwin III <wli@holomorphy.com>, Marc Singer <elf@buici.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040417215257.GA9691@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417213333.GS743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417213333.GS743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 02:33:33PM -0700, William Lee Irwin III wrote:
> On Sat, Apr 17, 2004 at 12:38:55PM -0700, William Lee Irwin III wrote:
> >> Marc Singer reported an issue where an embedded ARM system performed
> >> poorly due to page replacement potentially prematurely replacing
> >> mapped memory where there was very little mapped pagecache in use to
> >> begin with.
> >> Marc Singer has results where this is an improvement, and hopefully can
> >> clarify as-needed. Help determining whether this policy change is an
> >> improvement for a broader variety of systems would be appreciated.
> 
> On Sat, Apr 17, 2004 at 02:29:58PM -0700, Marc Singer wrote:
> > I have some numbers to clarify the 'improvement'.
> > Setup:
> >   ARM922 CPU, 200MHz, 32MiB RAM
> >   NFS mounted rootfs, tcp, hard, v3, 4K blocks
> >   Test application copies 41MiB file and prints the elapsed time
> > The two scenarios differ only in the setting of /proc/sys/vm/swappiness.
> 
> This doesn't match your first response. Anyway, this one is gets
> scrapped. I guess if swappiness solves it, then so much the better.

Huh?  Where do you see a discrepency?  I don't think I claimed that
the test program performance changed.  The noticeable difference is in
interactivity once the page cache fills.  IMHO, 30 seconds to do a
file listing on /proc is extreme.



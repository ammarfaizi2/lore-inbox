Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSKSOF5>; Tue, 19 Nov 2002 09:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKSOF5>; Tue, 19 Nov 2002 09:05:57 -0500
Received: from ns.suse.de ([213.95.15.193]:529 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265469AbSKSOF4>;
	Tue, 19 Nov 2002 09:05:56 -0500
Date: Tue, 19 Nov 2002 15:12:59 +0100
From: Andi Kleen <ak@suse.de>
To: Rik van Riel <riel@conectiva.com.br>, Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       margit@margit.com
Subject: Re: Linux 2.4.19 patch for Suse compatibility
Message-ID: <20021119141259.GA19880@wotan.suse.de>
References: <p73d6p1vi7c.fsf@oldwotan.suse.de> <Pine.LNX.4.44L.0211191132280.1571-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211191132280.1571-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:32:45AM -0200, Rik van Riel wrote:
> On 19 Nov 2002, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > This was discussed on the kernel list about four to six weeks ago and
> > > rejected then as well. See the previous discussion
> >
> > Actually I don't remember it being rejected, just the discussion dropped
> > off and there was no suggestion on how to solve the problem this ioctl
> > solves in a better way.
> 
> So, what problem does it try to solve ?

The output of all the startup scripts is logged by a special daemon to 
a log file (blogd). It does this by redirecting /dev/console.

For it to be able to still output something to the screen and later 
resetting the console it needs to know the output device that
/dev/console maps to. The ioctl returns it. 

There is actually a fallback path that tries to discover the underlying
device when the ioctl is not there, but it is far too ugly to describe
and also has some problems.

-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279530AbRJXLgp>; Wed, 24 Oct 2001 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279535AbRJXLgZ>; Wed, 24 Oct 2001 07:36:25 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:20747 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S279530AbRJXLgS>; Wed, 24 Oct 2001 07:36:18 -0400
Date: Wed, 24 Oct 2001 13:36:40 +0200
From: Kurt Roeckx <Q@ping.be>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
Message-ID: <20011024133639.A2225@ping.be>
In-Reply-To: <3BD5AED6.90401C9C@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD5AED6.90401C9C@sun.com>; from thockin@sun.com on Tue, Oct 23, 2001 at 10:54:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:54:30AM -0700, Tim Hockin wrote:
> So we've noticed, and taken issue with this behavior.
> 
> If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
> get inconsistent behavior when downing them.
> 
> * if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
> * if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too

This was reported ages ago too.

>From what I remember, because eth0:x is an AF_INET hack only, you
should only do a down of it with an AF_INET socket.  Some
versions of ifconfig did it with a socket of the wrong type,
which resulted in the whole interface going down.

Which version of ifconfig (nettools) are you using?


Kurt


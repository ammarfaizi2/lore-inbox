Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281169AbRKEOvP>; Mon, 5 Nov 2001 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281172AbRKEOvG>; Mon, 5 Nov 2001 09:51:06 -0500
Received: from smtp2.us.dell.com ([143.166.82.242]:38617 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S281168AbRKEOu5>; Mon, 5 Nov 2001 09:50:57 -0500
Date: Mon, 5 Nov 2001 08:50:55 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Tux mailing list <tux-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.30.0111051429040.18879-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111050849090.2102-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Roy Sigurd Karlsbakk wrote:

> Just one thing...
> 
> I need redundancy, so I can't go with RAID 0. I thought I'd go with RAID
> 4, to avoid reading the parity info (and thereby wasting time), and still
> have some quite good redundancy.
> 
> Q: Should I use hardware RAID or software RAID here? I can see they've
> been using a rather large stripe (or chunk) size on the RAID (2MB). The
> RAID controller I planned to use only supports up to 512kB stripes. As I
> said, the files I'm reading are rather large - up to 10GB each, or at
> least 1GB. I'm reading 4-7Mbps (500-900kB) per connection and each
> connection reads only one file. Will a large stripe size help me here?

If you spec your boxes such that you have extra CPU cycles around after
TUX is done, consider software raid. Software raid is faster than hardware
raid in almost every circumstance I have seen, with the caveat that it
uses slightly more CPU resources (RAID 5 has worst CPU performance because
of parity calculations, RAID 1 is better)

-- 
Michael E. Brown, RHCE, MCSE+I, CNA
Dell Linux Solutions
http://www.dell.com/linux

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.



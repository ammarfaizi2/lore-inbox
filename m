Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWB0TWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWB0TWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWB0TWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:22:13 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:2366 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751748AbWB0TWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:22:12 -0500
In-Reply-To: <20060227190150.GA9121@kroah.com>
References: <20060227190150.GA9121@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8C0F522E-E21E-40DD-8EFA-6D1111AF4CA1@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Date: Mon, 27 Feb 2006 13:22:05 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 27, 2006, at 1:01 PM, Greg KH wrote:

> Hi all,
>
> As has been noticed recently by a lot of different people, it seems  
> like
> we are breaking the userspace<->kernelspace interface a lot.  Well, in
> looking back over time, we always have been doing this, but no one  
> seems
> to notice (proc files changing format and location, netlink library
> bindings, etc.)
>
> Linux is a dynamic system, we add and change things all the time based
> on the need of its developers and users.  Because of this, we now  
> run on
> more platforms than any other operating system ever has, from the
> world's top supercomputers, to the phone in your pocket.  It is how we
> have survived so far, and is how we will survive in the future.
>
> In order to ensure that we can continue to be dynamic in the  
> future, and
> not get bogged down by interfaces that are half-baked, or just turn  
> out
> to be wrong once we implement them and find ways to break them (anyone
> remember the sys_futex evolution?) we need to be able to handle the
> changes in the userspace<->kernelspace ABI properly.
>
> So, here's a first cut at how we can do this.  Lots of other operating
> systems explicity document what the interfaces to it are, and give a
> "stability" rating of those interfaces (for one example, look at
> http://opensolaris.org/os/community/onnv/devref_toc/devref_7/ ).  I  
> feel
> that we too need to document this interface, in order to keep everyone
> in the loop and not cause any unwanted surprises at times they do not
> need them (like right before a company's deadline.)
>
> I've sketched out a directory structure that starts in
> Documentation/ABI/ and has five different states, "stable", "testing",
> "unstable", "obsolete", and "private".  The README file describes  
> these
> different states, and how things can move between them.  I've also
> seeded the directories with some well known examples of the different
> interfaces that are already in these states.
>
> So, any comments?  Criticisms?

It would be nice if we can come up with some way for Linus to  
document state changes in his release notes.

- kumar

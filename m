Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136761AbREAXOe>; Tue, 1 May 2001 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136764AbREAXOV>; Tue, 1 May 2001 19:14:21 -0400
Received: from mail.wave.co.nz ([203.96.216.11]:11850 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S136762AbREAXN7>;
	Tue, 1 May 2001 19:13:59 -0400
Date: Wed, 2 May 2001 11:13:53 +1200
From: Mark van Walraven <markv@wave.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010502111353.A13981@mail.wave.co.nz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14pfQ3-0003bG-00@the-village.bc.nu> <9bo88b$qa5$1@post.home.lunix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <9bo88b$qa5$1@post.home.lunix>; from Ton Hospel on Fri, Apr 20, 2001 at 02:51:55AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 02:51:55AM +0000, Ton Hospel wrote:
> Resettable counters are evil.

Perhaps "evil" should be reserved to describe counters which automatically
reset as a side effect of being read.

> I really think cisco got this right: from the commandline interface
> you can reset counters, and watch them, the SNMP counters however just
> keep going and going and going independently from this.

Except for the IP accounting table?  The 'checkpoint' operation copies and
*clears* the table ...

I don't really need snapshots, just hazard-free reads.  It's quite
easy to work out deltas in userspace, but I'd hate for things to be
unnecessarily painful for multiple readers.

Mark.

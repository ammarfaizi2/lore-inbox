Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280921AbRKGTW5>; Wed, 7 Nov 2001 14:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280923AbRKGTWr>; Wed, 7 Nov 2001 14:22:47 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:15262 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280921AbRKGTWl>; Wed, 7 Nov 2001 14:22:41 -0500
Date: Wed, 7 Nov 2001 14:21:19 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Blue Lang <blue@b-side.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <Pine.LNX.4.30.0111071212430.9535-100000@gib.soccerchix.org>
Message-ID: <Pine.GSO.4.33.0111071409530.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Blue Lang wrote:
>I understand where the binary crowd is coming from as far as collation
>goes, but I personally use the simple stuff every day (cat /proc/pci) and
>any sort of aggregate/collation tool (lspci) almost never.

Just as an aside, /proc/pci was slated for deletion a long time ago.  There
were warnings emitted by the kernel every time something accessed it for
some time.  /proc/pci is dependent on a (large) list of names being in the
kernel to map the numbers to text.  I think the plans to kill /proc/pci
have been abandoned, however. (The table makes the kernel big, but most of
it gets released once the pci bus scan is complete ala __init_data.)

As for code maint. and kernel changes breaking things... both happen already
with the text based system.  Binary structures can be constructed to be
extensible without breaking old tools.  Plus, the information exported from
the kernel (in the case of processes) need not change with every version
of the kernel.

I don't think people realize just how many CPU cycles are being needlessly
expended in passing information between the kernel and the user.  When I
have the time, I'll add binary interfaces for various things and show exactly
how expensive the existing system is -- all for the sake of being able to
use 'cat' and 'grep'.

--Ricky



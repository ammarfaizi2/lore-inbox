Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVLAJDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVLAJDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVLAJDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 04:03:23 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:6086 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750773AbVLAJDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 04:03:22 -0500
Message-ID: <438EBD21.5050907@aitel.hist.no>
Date: Thu, 01 Dec 2005 10:06:41 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net> <Pine.LNX.4.58.0511300821570.18317@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511300821570.18317@shark.he.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>Just for the sake of understanding the current kernel release
>process, when would something like this be acceptable/possible?
>Would it require a Linux 3.0 version, or at least a 2.8?
>  
>
No.  It has been stated many times that there is no guarantee about
binary compatibility. So this sort of change (breaking out-of-tree
assembly or other code) can happen at anytime, even in a stable series, 
even if
the reason for the change isn't very strong.  You will even find those
who want to break binary compatibility occationally on purpose, just to get
people firmly off the idea that they can depend on such things.

The reason for the last attitude is the preference for open source.
Vendors may like binary drivers, but they have a history of bad
maintainership, especially when the product no longer sell. Open source
is then useful in that any interested programmer can fix things.  That's
almost impossible with binary stuff.  Sort of  "if they want to be 
difficult to us,
then we'll be difficult to them."

Getting out-of-tree code into the kernel tree is one way of avoiding
trouble, because then the people making changes will try hard not
to break anything. This is obviously not an option for non-gpl code,
search the mail archives for how many times kernel changes
broke the binary modules of vmware, nvidia and others.

Policy is that those who keep their code to themselves gets
to play catchup - a lot.  Their trouble is a non-issue.
Exceptions have sometimes been made in
order to not break the kernel for large amounts of people.  Apparently,
the number of people using nvidia/vmware/out-of-tree assembly
isn't considered large enough, or at least the changes have been
more important than their troubles.

Helge Hafting


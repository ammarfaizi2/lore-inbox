Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbTGINWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbTGINWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:22:32 -0400
Received: from 69-55-72-142.ppp.netsville.net ([69.55.72.142]:50371 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S268253AbTGINWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:22:30 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>, green@namesys.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030709140138.141c3536.skraw@ithnet.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	 <1057515223.20904.1315.camel@tiny.suse.com>
	 <20030709140138.141c3536.skraw@ithnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057757764.26768.170.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Jul 2003 09:36:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 08:01, Stephan von Krawczynski wrote:
> On 06 Jul 2003 14:13:44 -0400
> Chris Mason <mason@suse.com> wrote:
> 
> > [...]
> > Is reiserfs on your root drive?  If not can you please boot into single
> > user mode, enable sysrq, try the mount again and get the decoded output
> > from sysrq-p and sysrq-t if it hangs.
> > 
> > -chris
> 
> Hello Chris,
> 
> I tried to produce some useful output but failed. Additionals I found:
> 
> - pre3-ac1 has the same problem
> - the box _hangs_ in fact, no sysrq is working.
>   (you need hw-reset to revive the box)
> - I can see no disk activity on the 3ware RAID in question
> - It always shows up, completely reproducable
> - It shows during boot and during single- or multiuser (mount from console)

Step one is to figure out if the problem is reiserfs or 3ware.  Instead
of mounting the filesystem, run debugreiserfs -d /dev/xxxx > /dev/null
and see if you still hang.

This will read the FS metadata and should generate enough io to trigger
the hang if it is a 3ware problem.

(I'm on vacation for a few days, so Oleg is cc'd)

-chris



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbTHFUSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHFUSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:18:15 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:5552 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S270925AbTHFUSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:18:14 -0400
Date: Wed, 6 Aug 2003 22:18:06 +0200
From: Frank van de Pol <fvdpol@home.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, dan@debian.org,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: md+ext3 badness in 2.6.0-test2
Message-ID: <20030806201806.GA14124@obelix.fvdpol.dyndns.org>
References: <20030804142245.GA1627@nevyn.them.org> <20030804132219.2e0c53b4.akpm@osdl.org> <16176.41431.279477.273718@gargle.gargle.HOWL> <20030805235735.4c180fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805235735.4c180fa4.akpm@osdl.org>
X-Operating-System: Linux 2.4.21-pre2 i686
User-Agent: Mutt/1.5.4i
X-MailScanner-Information: Please contact support@home.nl for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Aug 05, 2003 at 11:57:35PM -0700, Andrew Morton wrote:
> 
> > ...
> > Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1): ext3_add_entry: bad entry in directory #41
> > 009295: rec_len is smaller than minimal - offset=0, inode=3265411686, rec_len=0, name_len=0
> 
> It looks like we had a block full of zeroes come back from the device
> driver.  I find it distinctly fishy how this happens so much with
> ext3-on-md, and so little with ext3-on-just-a-disk.
> 

I'm seeing these kind of errors also on my box when running late 2.5.x /
2.6.0-preX kernels. 2.4 is stable on this box. The affected filesystems are
also ext3 on md (using raid5 volume). 

I was suspecting that it had something to with memory corruption (memtest
does not find any problems) triggered by the hashes introduced during 2.5 or
some locking issue since my box is a dual P-II. 

Interesting to see that others are experience these kind of problems as
well, and even more interesting is the relation to md.

Frank.

-- 
+---- --- -- -  -   -    -
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

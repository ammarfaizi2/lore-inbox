Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRICEE0>; Mon, 3 Sep 2001 00:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271214AbRICEER>; Mon, 3 Sep 2001 00:04:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:49681 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271186AbRICEEH>; Mon, 3 Sep 2001 00:04:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Mon, 3 Sep 2001 14:04:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.317.368058.431207@notabene.cse.unsw.edu.au>
Subject: RFC - how to quota special characters in filenames in /proc files
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings.

I am interested in opinions that people might have on how to quote
special characters in filenames in files in /proc.

The particular filenames of interest are those in
     /proc/fs/nfs/exports

This file lists the directories that have been exported, what hosts
they are exported to, and what export options apply.

The lines are made of space-sparated fields.  The first field is the
directory name.

So what happens when you export a directory which has a space in it's
name?  Currently this doesn't work too well.

My preference is to replace all control characters, spaces, DEL, and '%'
with a %hex string much like the special character quoting in
URLs.

Other alternatives that I don't like is to preceed special characters
with '\'  or to use =hex instead of %hex, like MIME encoding does.

So:
  is there any good reason why I should choose something other than %hex?  
  is there any convention already used in some other part of the
    kernel.

In the longer term it would probably be better to use a directory
rather than a file, and present all file names as symlinks so quoting
isn't needed.  However I don't see that as a short term solution and I
think a short term solution is needed.


Thankyou for your time.

NeilBrown

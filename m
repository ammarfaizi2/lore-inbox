Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbREHMmf>; Tue, 8 May 2001 08:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbREHMmZ>; Tue, 8 May 2001 08:42:25 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:39435 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131481AbREHMmJ>; Tue, 8 May 2001 08:42:09 -0400
From: r1vamsi@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: kdb@oss.sgi.com
cc: linux-kernel@vger.kernel.org, richardj_moore@uk.ibm.com,
        hanrahat@us.ibm.com
Message-ID: <CA256A46.0045B034.00@d73mta03.au.ibm.com>
Date: Tue, 8 May 2001 18:10:53 +0530
Subject: Re: kdb wishlist
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

I have worked on the making md/mm take the width option using BYTESPERWORD.
I will be happy to work on this.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: r1vamsi@in.ibm.com


Keith Owens <kaos@melbourne.sgi.com> on 05/08/2001 05:39:42 PM

Please respond to Keith Owens <kaos@melbourne.sgi.com>

To:   kdb@oss.sgi.com, linux-kernel@vger.kernel.org
cc:    (bcc: S Vamsikrishna/India/IBM)
Subject:  kdb wishlist




This is part of my kdb wishlist, does anybody fancy writing the code to
add any of these features?  It would be a nice project for anybody
wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
Current patches at http://oss.sgi.com/projects/kdb/download/

* Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
  used by emacs, bash, minicom etc.

* Command history.  Handle up/down/left/right/delete keys.  Each
  kdba_io routine is responsible for recognising the arch specific
  keys, with a common history and editting routine.

* Clean up repeating commands.  Pressing enter at the kdb prompt
  repeats the previous command, no matter what the previous command
  was.  Some commands it makes no sense to repeat (bp in particular),
  for other commands you want to repeat the command but without the
  parameter (md in particular).

* Embed width and count options in md and mm commands.  Some hardware
  requires that accesses be a specific width, this can be achieved by
  setting BYTESPERWORD but it is awkward.  We want md1 to read one
  byte, md2, md4, md8 commands.  All can have a count field, e.g.
  md1c8 reads 8 bytes one at a time.  mm1, mm2, mm4, mm8 to set memory
  no count field.



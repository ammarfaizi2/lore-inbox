Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264838AbUD1P5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264838AbUD1P5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264841AbUD1P5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:57:13 -0400
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:39857 "EHLO
	localhost") by vger.kernel.org with ESMTP id S264838AbUD1P5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:57:11 -0400
Date: Wed, 28 Apr 2004 10:56:46 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040428155643.GC26041@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <408F3EE4.1080603@nortelnetworks.com> <opr65ic90vshwjtr@laptop-linux.wpcb.org.au> <20040428121009.GA2844@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428121009.GA2844@thunk.org>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Theodore Ts'o on Wednesday, 28 April, 2004:
[mucho mas snipping]
>The thing we could do kernel-side is to implement full VM protections.
>This is the microkernel approach; the problem though is the
>performance overhead of having to go through protection boundaries,
>setting up kernel-module-specific VM page tables, etc., etc.  At some
>level, if people could implement these propeitary code bases in
>userspace, then there would be no need to risk corrupting internal
>data structures, and no need to "taint" the kernel.  But usually there
>are performance reasons why the driver authors choose not to go down
>that path.

Would it be possible to, instead of implementing a full vm system inside
  the kernel for device drivers, to provide a way to have the binary
  drivers be a userland process?
I'd love to be able to keep binary drivers out of my kernel, and I
  know many people harp on how hard it is to maintain binary drivers in
  the Linux kernel due to the rapid evolution of Linux (namely, how fast
  interfaces and structures change).  If there were a way to put these
  binary drivers in userspace, we could potentially solve both problems
  in one swipe, no?

-Joseph
-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html

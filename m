Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWFIRMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWFIRMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWFIRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:12:50 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:36056 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1030309AbWFIRMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:12:48 -0400
From: "Jeff Anderson-Lee" <jonah@eecs.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
Cc: "'ext2-devel'" <ext2-devel@lists.sourceforge.net>,
       <linux-fsdevel@vger.kernel.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Date: Fri, 9 Jun 2006 10:12:39 -0700
Message-ID: <000001c68be7$e9ed7f40$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
Thread-Index: AcaL52HIwXOFgkfVSS+rkCsvLZF2Nw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 9 Jun 2006, Alex Tomas wrote:
>  
> > I believe it's as stable as before until you mount with extents
> > mount option.
>    
> In contrast, the last time two different filesystems introduced bugs in 
> each other was approximately "never". They simply don't modify each others

> code, they don't look at each others data structures, and they don't jump 
> into each others routines.

As an interested bystander (and large filesystem user), I'd say I tend to 
agree with Linus and Jeff on this one.

* ext3 is arguably the main Linux filesystem: too important to keep 
  "experimenting" with.

* I'd encourage a >2TB version, but call it ext4.  It makes it clear
  that you are entering new territory.

* Take advantage of the switch to remove some of the backward compatibility
  cruft from the ext4 version -- make it a clean, explicit break.

* [Possibly even inoculate ext3 against creeping featuris and work on 
  cleanup and optimization instead.]

This is not intended to slight the work/position of the ext3 developers,
merely to inform them of an end-user's perspective.

----
Jeff Anderson-Lee
Petabyte Storage Infrastructure Project
University of California Berkeley
"Simplify, simplify, simplify." -- Henry David Thoreau 
"I think one 'simplify' would have sufficed." -- Ralph Waldo Emerson 


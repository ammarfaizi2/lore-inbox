Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSLFPQ2>; Fri, 6 Dec 2002 10:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSLFPQ2>; Fri, 6 Dec 2002 10:16:28 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:17679 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S262937AbSLFPQ0>; Fri, 6 Dec 2002 10:16:26 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: linux-kernel@vger.kernel.org
Subject: Detecting threads vs processes with ps or /proc
Date: Fri, 6 Dec 2002 09:24:02 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212060924.02162.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

>From searching through mail archives, etc., I'm pretty sure I know the answer 
already, but I'm going to post it anyway.

Our software (Condor) and some related software (Globus) is running on a 
number of systems around the world.  Condor attempts to monitor the RAM usage 
of it's "user" (maybe "client" is a better word here) processes.  If the 
client forks, we need to monitor the client and all of it's children, which 
really isn't difficult.  The _problem_ is that if the client creates threads, 
it's impossible, from what we can tell, to tell the difference between 
separate threads and processes.

So my question, I guess, is this.  How can you tell, from user space, whether 
a group of processes are related as threads or through a "normal" child / 
parent relationship?  The systems that we're running on currently are 2.2.19 
and 2.4.18/19.

>From what else I've read, it seems that the new threading model in 2.5/2.6 is 
changing to a more POSIX friendly model, which will effect this answer, but 
we're not running 2.5 and really can't force such an upgrade -- hell, right 
now we're having problems getting a switch from 2.2 pushed through.

Thanks _very_ much in advance.  I'd be tickled pink if the answer is something 
like "just look at the foo flag in ps", or "upgrade to version 1.2.3.4 of 
procps and do xyzzy", but my intuition tells me otherwise.

Thanks,

-Nick



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBUWCq>; Wed, 21 Feb 2001 17:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRBUWC0>; Wed, 21 Feb 2001 17:02:26 -0500
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:35003 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S129842AbRBUWCT>; Wed, 21 Feb 2001 17:02:19 -0500
Message-ID: <20010221220217.29816.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Wed, 21 Feb 2001 23:02:17 +0100
To: linux-kernel@vger.kernel.org
Subject: Long standing bug in alternate stack handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just found this out the hard way:

If a signal handler is registered with the SA_ONSTACK flag the
kernel will try to execute the signal handler on the alternate
stack even if no such stack is registered.
This is an explicit violation of Unix98 and probably Posix.

Architectures affected include at least i386 (don't know about others).


     regards Christian

-- 
THAT'S ALL FOLKS!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161351AbWKERBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbWKERBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWKERBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:01:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:10112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161351AbWKERBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:01:23 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Date: Sun, 5 Nov 2006 18:01:18 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <200611050641.14724.ak@suse.de> <454D9A75.7010204@vmware.com>
In-Reply-To: <454D9A75.7010204@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051801.18277.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> sti is expensive as well; iirc just as expensive on most processors as 
> popf, 


On K8 STI is 4 cycles.

> although I don't have hard numbers to back this up on hand.  An  
> _unlikely_ jcc + popf? is better than a sti, for sure, but a likely 
> jcc+popf could cost more than a jcc+sti, depending on model.

99.9999% of all restore_flags just need STI.


-Andi

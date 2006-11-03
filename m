Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753441AbWKCSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbWKCSlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbWKCSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:41:36 -0500
Received: from mx1.suse.de ([195.135.220.2]:56960 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753441AbWKCSlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:41:36 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] i386: remove IOPL check on task switch
Date: Fri, 3 Nov 2006 19:41:28 +0100
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200611030130_MC3-1-D02A-DEB@compuserve.com> <454B850C.3050402@vmware.com>
In-Reply-To: <454B850C.3050402@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031941.28907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Nack.  This is used for paravirt-ops kernels that use IOPL'd userspace.  
> Fixing it would require a fairly heavy penalty on the iret path, since 
> every single instruction there contributes to a critical region which 
> must have custom fixup code, or some other technique to provide 
> protection against interrupt re-entrancy.
> 
> At least, let's discuss other potential solutions first - for now it is 
> harmless.

Ok I will drop the patch again

-Andi

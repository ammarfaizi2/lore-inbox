Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWJSN1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWJSN1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWJSN1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:27:50 -0400
Received: from mail.suse.de ([195.135.220.2]:3310 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751611AbWJSN1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:27:49 -0400
From: Andi Kleen <ak@suse.de>
To: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: Unnecessary BKL contention in video1394
Date: Thu, 19 Oct 2006 15:27:42 +0200
User-Agent: KMail/1.9.3
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1161203487.28713.8.camel@systems03.lan.brontes3d.com> <45369E69.30007@s5r6.in-berlin.de> <1161263978.2845.6.camel@systems03.lan.brontes3d.com>
In-Reply-To: <1161263978.2845.6.camel@systems03.lan.brontes3d.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191527.42802.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Adding Andi Kleen to CC, who added the BKL around __video1394_ioctl a
> long while back (when converting video1394 to compat_ioctl).
> 
> I don't feel that any replacement protection is needed, since the
> critical sections (where structures are used both in interrupts and in
> file_operations) are already protected by spinlocks.

Fine by me. I just did it to preserve old semantics because I didn't want
to audit the 1394 locking.  But if you think it's not needed feel free to remove
them.

-andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVERK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVERK5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVERK5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:57:01 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27301 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262145AbVERK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:56:45 -0400
Subject: Re: Broken scsi on 2.6.12rc4 +
	realtime-preempt-2.6.12-rc4-V0.7.47-03 ( adaptec aic7901a and lsi 53c1030
	fusion-mpt )
From: Steven Rostedt <rostedt@goodmis.org>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116408679.3391.48.camel@ibiza.btsn.frna.bull.fr>
References: <1116408679.3391.48.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 18 May 2005 06:56:38 -0400
Message-Id: <1116413798.22094.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 11:31 +0200, Serge Noiraud wrote:
> The kernel with the realtime-preempt-2.6.12-rc4-V0.7.47-03 patch works
> well on IDE.
> I have a cannot open root device at boot on two machines ( i386 ) with
> aic79xx or LSI controler.
> If I suppress the realtime patch, it works.
> I tried to set different options for realtime without success.
[...]
> During boot the following error occurs :
> ...
> VFS: Cannot open root device "0806" or unknown-block(8,6)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(8,6)
> 
> Any idea ?

This looks like the same error you would get if these drivers were
compiled as modules and not placed in the initrd.  The RT patch adds the
-V0.7.47-03 to the version of the kernel so the modules do get loaded
into a different /lib/modules directory and should have a different
initrd file.  Make sure that your initrd is correct, or just compile the
necessary modules into the kernel (not as modules).

-- Steve



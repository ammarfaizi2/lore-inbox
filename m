Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUIYRPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUIYRPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUIYRPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:15:31 -0400
Received: from dp.samba.org ([66.70.73.150]:62696 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269367AbUIYRPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:15:17 -0400
Date: Sat, 25 Sep 2004 10:14:36 -0700
From: Jeremy Allison <jra@samba.org>
To: Jeremy Allison <jra@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925171436.GO580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925171104.GN580@jeremy1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 10:11:04AM -0700, Jeremy Allison wrote:

> Besides which, on HPUX (which these extensions were
> first created for) it returns st_blocks in 8192 byte
> units, not 512, so your claim is incorrect.

Oh yeah, and checking our configure.in, Stratos VOS
uses 4096 for the same units. That's when I gave up
in horror (I, like you, used to think it was 512 :-).
The original smbclient test code failed to return the
correct value when connecting to HPUX because of this,
we used to multiply by 512 bytes to show the user the
complete number.

Jeremy "standard, what standard ?" Allison.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTBJIDe>; Mon, 10 Feb 2003 03:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTBJIDd>; Mon, 10 Feb 2003 03:03:33 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:10479 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264697AbTBJIDd>; Mon, 10 Feb 2003 03:03:33 -0500
Date: Mon, 10 Feb 2003 00:11:18 -0800
From: Chris Wright <chris@wirex.com>
To: LA Walsh <law@tlinx.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030210001118.A7252@figure1.int.wirex.com>
Mail-Followup-To: LA Walsh <law@tlinx.org>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, linux-security-module@wirex.com
References: <3E471F21.4010803@wirex.com> <048601c2d0d6$cda31130$1403a8c0@sc.tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <048601c2d0d6$cda31130$1403a8c0@sc.tlinx.org>; from law@tlinx.org on Sun, Feb 09, 2003 at 11:34:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* LA Walsh (law@tlinx.org) wrote:
> 	Maybe I'm delusional, but you are contradicting yourself.  In

Re-read Linus' original spec with the following things in mind:
- we don't interpose at the system call level, rather the kernel object level
- we tag about 8 objects
- we have about 150 callbacks
- we don't move the capabilities bits from the task struct to the opaque id
- we allow active filtering
- we discourage generic policy composition
- we support models such as MLS, TE, DTE, RBAC, Capabilities, PBAC/TBAC
  (whatver you want to call it), etc.

The fact that we don't support CAPP or LSPP standard compliant systems
which require MAC checks before DAC checks for _auditing_ is outside the
scope of this access control system.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUDUSnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUDUSnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbUDUSnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:43:14 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:37559 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263596AbUDUSnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:43:13 -0400
Subject: Re: compute_creds fixup in -mm
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040421112827.O21045@build.pdx.osdl.net>
References: <20040421010621.L22989@build.pdx.osdl.net>
	 <4086AEFC.5010002@myrealbox.com>
	 <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>
	 <20040421112827.O21045@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Apr 2004 14:42:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 14:28, Chris Wright wrote:
> * Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> > I didn't see Chris' patch.  I assume that the worst case is unexpected
> > program failure due to lack of capability, right?  The SELinux security
> 
> The opposite.  You'd get a program with non-root euid, but full
> capability set, and AT_SECURE set false.  My patch is below.

Sorry, I wasn't clear.  I meant the worst case due to the share/ptrace
state check being duplicated in SELinux and in commoncap, as opposed to
being performed once as in Andy's patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTADUxD>; Sat, 4 Jan 2003 15:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTADUxD>; Sat, 4 Jan 2003 15:53:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34065 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261463AbTADUxC>;
	Sat, 4 Jan 2003 15:53:02 -0500
Date: Sat, 4 Jan 2003 22:01:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mad Hatter <slokus@yahoo.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 Makefile question: set -e
Message-ID: <20030104210135.GA5993@mars.ravnborg.org>
Mail-Followup-To: Mad Hatter <slokus@yahoo.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030104200415.7387.qmail@web13708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030104200415.7387.qmail@web13708.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 12:04:15PM -0800, Mad Hatter wrote:
> Hi,
> 
> The toplevel Makefile in 2.5.54 has near line 313:
> 
> ----------------------------
> #	set -e makes the rule exit immediately on error
> #...
> attribute if uninitialized.
> 
> define rule_vmlinux__
> 	set -e
> ...
> endef
> -------------------------
> 
> However, the "set -e" does nothing since each line is
> processed by a different shell according to the make
> manual.

The "set -e" seems superflous in this context.
set -e is IIRC only relevant when commands are chined like:

set -e; \
cd $(srctree); \
mkdir somedir; \
do somthing;

Kai?

	Sam

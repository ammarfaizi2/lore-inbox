Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWAEEWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWAEEWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWAEEWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:22:37 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:31461 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751920AbWAEEWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:22:36 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: remove duplicate IDs
Date: Thu, 05 Jan 2006 15:22:34 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <346pr1th3rlm1rh1im2sjikn6grdrctrn5@4ax.com>
References: <1isor19fmroc4ue21gnqkp6k1ln1pp06r1@4ax.com> <p5uor1lhum4ilra154o27e4vglvccd0v0a@4ax.com> <20060105034213.GA23613@kroah.com>
In-Reply-To: <20060105034213.GA23613@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 19:42:13 -0800, Greg KH <greg@kroah.com> wrote:

>On Thu, Jan 05, 2006 at 12:40:12PM +1100, Grant Coady wrote:
>> On Thu, 05 Jan 2006 12:14:16 +1100, Grant Coady <grant_lkml@dodo.com.au> wrote:
>> 
>> >
>> >From: Grant Coady <gcoady@gmail.com>
>> >
>> >pci_ids.h: removes eight duplicate IDs that crept in during the 
>> > 2.6.15 development cycle, commented a duplicate where one ID was 
>> > defined in terms of another.  Compile tested with allyesconfig.
>> >
>> >Signed-off-by: Grant Coady <gcoady@gmail.com>
>> 
>> Sorry gang, please scratch.  I'll wait for -mm1
>
>Why scratch, what was wrong?

'Cos sometimes I do incredibly dumb things like copy 2.6.14 over 
2.6.15 (well it was the a and b), so:

grant@sempro:~/linux$ do-device-id linux-2.6.15
find pci_ids defined
find symbols in source tree
find source defined symbols files
summary, line counts:
  1797 symbols-pci_ids.h-define
     0 symbols-pci_ids.h-dups			<<== no duplicates
  2194 symbols-pci_ids.h-new
  2194 symbols-pci_ids.h-orig
  1933 symbols-source-all
   433 symbols-source-define
   104 symbols-source-define-files		<<== clean these up??
  1214 symbols-source-files-include-pci.h
    29 symbols-source-files-include-pci_ids.h

The patch to scratch was really a 2.6.14 pretending to be 2.6.15, 
not wanted by anybody.

Then I was intending to start on the source files then define or 
redefine PCI IDs, removing those defines to the main pci_ids.h 
file.

>I'd suggest working against Linus's git tree, that might be a bit
>simpler than the -mm tree, and is what I merge against.

Okay, thanks,
Grant.

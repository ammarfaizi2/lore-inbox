Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUEXAZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUEXAZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUEXAZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:25:29 -0400
Received: from CPE-203-51-26-94.nsw.bigpond.net.au ([203.51.26.94]:1778 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S263766AbUEXAZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:25:27 -0400
Message-ID: <40B140DF.2070300@eyal.emu.id.au>
Date: Mon, 24 May 2004 10:25:03 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1 - drivers/scsi/ipr.h too smart for me...
References: <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Hmm.. This is stuff all over the map, but most interesting (or at least
> most "core") is probably the merging of the NUMA scheduler and the anonvma
> rmap code. The latter gets rid of the expensive pte chains, and instead
> allows reverse page mapping by keeping track of which vma (and offset)  
> each page is associated with. Special kudos to Andrea Arcangeli and Hugh
> Dickins.

I see many anonymous unions used in drivers/scsi/ipr.h:

drivers/scsi/ipr.h:460: warning: unnamed struct/union that defines no instances
drivers/scsi/ipr.h:620: warning: unnamed struct/union that defines no instances
drivers/scsi/ipr.h:665: warning: unnamed struct/union that defines no instances
drivers/scsi/ipr.h:788: warning: unnamed struct/union that defines no instances
drivers/scsi/ipr.h:942: warning: unnamed struct/union that defines no instances

that my Debian stable (gcc 2.95.4) does not understand. Changes still says:

o  Gnu C                  2.95.3

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUHXLA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUHXLA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUHXLA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:00:27 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:58026 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267451AbUHXLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:00:25 -0400
Date: Tue, 24 Aug 2004 12:00:01 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix MTRR strings definition.
Message-ID: <20040824110001.GD28237@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040823232320.GA1875@redhat.com> <20040824081729.311ee677.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824081729.311ee677.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 08:17:29AM +0200, Andi Kleen wrote:
 > On Tue, 24 Aug 2004 00:23:20 +0100
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > Instead of deleting the extern from include/asm/mtrr.h, I believe
 > > the correct fix would be to move the strings back to the include file
 > > where they belong.
 > > The reason behind this, is that there are userspace apps (admittedly
 > > few, but we even ship two in Documentation/mtrr.txt) that rely upon
 > > these definitions being in that header.  This has been broken for
 > > all 2.6 releases so far. Patch below fixes things back the way it
 > > was in 2.4
 > 
 > That's rather ugly. It would be cleaner to just have a 
 > macro that expands to the strings, and everybody who wants to use
 > it declares an own array using that macro.

feel free to go rewrite the userspace that uses this.

 > > Andi, I don't have gcc 3.5 to hand, I trust this fixes whatever
 > > problem you saw there too ?
 > 
 > 3.5 doesn't like it when something is declared both extern and static.
 > Your new patch has this problem again.

The extern definitions no longer exist.

		Dave


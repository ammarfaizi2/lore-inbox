Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275248AbTHSAOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275250AbTHSAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:14:10 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12477 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275248AbTHSAOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:14:07 -0400
Date: Tue, 19 Aug 2003 01:13:16 +0100
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819001316.GF22433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Matt Mackall <mpm@selenic.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818140729.2e3b02f2.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 02:07:29PM -0700, Randy.Dunlap wrote:
 > | > |  > Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
 > | > |  > Call Trace:
 > | > |  >  [<c0120d94>] __might_sleep+0x54/0x5b
 > | > |  >  [<c010d001>] save_v86_state+0x71/0x1f0
 > | > |  >  [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
 > | > |  >  [<c019cab8>] ext3_file_write+0x28/0xc0
 > | > |  >  [<c011cd96>] __change_page_attr+0x26/0x220
 > | > |  >  [<c010b310>] do_general_protection+0x0/0x90
 > | > |  >  [<c010a69d>] error_code+0x2d/0x40
 > | > |  >  [<c0109657>] syscall_call+0x7/0xb
 > | > | 
 > 
 > I had another occurrence of this yesterday.  It doesn't seem to be
 > an error condition AFAICT.

How spooky. now I got one too, (minus the noise).

Call Trace:
 [<c0120022>] __might_sleep+0x5b/0x5f
 [<c010cf8a>] save_v86_state+0x6a/0x1f3
 [<c010dad2>] handle_vm86_fault+0xa7/0x897
 [<c010b2ed>] do_general_protection+0x0/0x93
 [<c010a651>] error_code+0x2d/0x38
 [<c0109623>] syscall_call+0x7/0xb

By the looks of the logs, it happened as I restarted X, as theres
a bunch of mtrr messages right after this..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk

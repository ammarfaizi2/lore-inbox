Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbTDATin>; Tue, 1 Apr 2003 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbTDATin>; Tue, 1 Apr 2003 14:38:43 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:53754 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262792AbTDATim>; Tue, 1 Apr 2003 14:38:42 -0500
Date: Tue, 1 Apr 2003 11:47:49 -0800
From: Chris Wright <chris@wirex.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mharrell-lk@bittwiddlers.com, andrew.grover@intel.com
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard during bootup
Message-ID: <20030401114749.A7647@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	mharrell-lk@bittwiddlers.com, andrew.grover@intel.com
References: <130680000.1049224849@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <130680000.1049224849@flay>; from mbligh@aracnet.com on Tue, Apr 01, 2003 at 11:20:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin J. Bligh (mbligh@aracnet.com) wrote:
> 
> http://bugme.osdl.org/show_bug.cgi?id=529
> 
>            Summary: ACPI under 2.5.50+ (approx) locks system hard during
>                     bootup
>     Kernel Version: 2.5.50 - 2.5.66 at least.  Trying to find the last one
>                     that work

Try >= 2.5.64.  It has a derive_pci_id ACPI patch that fixed this problem
for me[*].

ChangeSet@1.889.255.2, 2003-02-26 13:47:36-08:00, agrover@groveronline.com
  ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)

thanks,
-chris

[*] There is still a case where a warm reboot from a 2.4 kernel will
hang, but warm reboot from 2.5 kernel, or cold boot no longer hangs.
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

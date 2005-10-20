Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVJTOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVJTOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJTOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:44:28 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:17799 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751498AbVJTOo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:44:27 -0400
Subject: Re: [ACPI] [PATCH] `unaligned access' in acpi
	get_root_bridge_busnr()
From: Alex Williamson <alex.williamson@hp.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
References: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 20 Oct 2005 08:44:19 -0600
Message-Id: <1129819459.29828.2.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 13:37 +1000, Peter Chubb wrote:
> In drivers/acpi/glue.c the address of an integer is cast to the
> address of an unsigned long.  This breaks on systems where a long is
> larger than an int --- for a start the int can be misaligned; for a
> second the assignment through the pointer will overwrite part of the
> next variable.
> 

   FWIW, I posted a nearly identical patch back at the end of September:

http://marc.theaimsgroup.com/?l=acpi4linux&m=112775252600038

No word of it getting anywhere.  Thanks,

	Alex

-- 


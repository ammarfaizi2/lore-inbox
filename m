Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUHQQ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUHQQ1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUHQQ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:27:17 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12163 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265398AbUHQQ1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:27:16 -0400
Subject: Re: [PATCH][4/6]Register snapshotting before kexec-boot
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Suparna Bhattacharya [imap]" <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, litke@us.ibm.com,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20040817120911.GE3916@in.ibm.com>
References: <20040817120239.GA3916@in.ibm.com>
	 <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com>
	 <20040817120809.GD3916@in.ibm.com>  <20040817120911.GE3916@in.ibm.com>
Content-Type: text/plain
Message-Id: <1092760037.5415.74.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 09:27:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 05:09, Hariprasad Nellitheertha wrote:
> Regards, Hari
> +       /* Now copy over the saved task pointers and the registers
> +        * to the end of the  reserved area
> +        */
> +       dest_addr = (void *)(__va(CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE));

Why the cast?  Isn't __va() already returning a void*?

-- Dave


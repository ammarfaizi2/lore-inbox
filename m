Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUEADpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUEADpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUEADpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:45:06 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:36307
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S261786AbUEADpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:45:03 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
From: Michael Brown <Michael_E_Brown@Dell.com>
Reply-To: Michael_E_Brown@Dell.com
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <1083382204.1203.2971.camel@debian>
References: <1QvX0-A4-29@gated-at.bofh.it>
	 <m3r7u59sok.fsf@averell.firstfloor.org> <1083382204.1203.2971.camel@debian>
Content-Type: text/plain
Organization: Dell Inc
Message-Id: <1083383006.1197.2984.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 22:43:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 22:30, Michael Brown wrote:
> On Fri, 2004-04-30 at 14:22, Andi Kleen wrote:
> > Michael Brown <mebrown@michaels-house.net> writes:
> > 
> > > 	Below is an updated patch to add SMBIOS information to /proc/smbios.
> > > Updates have been made per Al's previous comments. Please apply.
> > 
> > What is this good for? There are tools to read this from
> > /dev/mem; and that is fine because the information is static.
> > There is no reason to bloat the kernel with this.

Sorry, I missed one other reason. 

This procfs/sysfs driver allows access to smbios information by
non-root, non CAP_SYS_RAWIO users. I've had several occasions where I
have been bitten by having to be root to read smbios when I did not need
root for anything else.
--
Michael


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbULCDOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbULCDOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULCDOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:14:33 -0500
Received: from fmr06.intel.com ([134.134.136.7]:682 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261908AbULCDOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:14:31 -0500
Subject: Re: APM suspend/resume ceased to work with 2.4.28
From: Len Brown <len.brown@intel.com>
To: Philippe Troin <phil@fifi.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@intel.com>
In-Reply-To: <87wtw0i1zb.fsf@ceramic.fifi.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B300225E3FC@hdsmsx401.amr.corp.intel.com>
	 <87d5xsjly5.fsf@ceramic.fifi.org> <871xeia26p.fsf@ceramic.fifi.org>
	 <87zn1amuov.fsf@ceramic.fifi.org><20041122173654.GA31848@logos.cnet>
	 <87mzx94ekm.fsf@ceramic.fifi.org><20041123070252.GA2712@logos.cnet>
	 <87wtw0i1zb.fsf@ceramic.fifi.org>
Content-Type: text/plain
Organization: 
Message-Id: <1102043636.8028.456.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Dec 2004 22:13:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 20:50, Philippe Troin wrote:
> Philippe Troin <phil@fifi.org> writes:

> This trivial patch makes my laptop suspend-happy.

Good catch Phil!

My fault -- we fixed this in 2.6 and I failed to backport it to 2.4:-(

I've included your patch w/ minor syntax change to the ACPI patch.

Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 drivers/acpi/bus.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/12/02 1.1458.1.9)
   [ACPI] acpi=off must disable acpi_early_init()
   
   Signed-off-by: Philippe Troin <phil@fifi.org>
   Signed-off-by: Len Brown <len.brown@intel.com>





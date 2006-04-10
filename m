Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDJOgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDJOgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWDJOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:36:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50114 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751176AbWDJOf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:35:59 -0400
Subject: [PATCH 0/7] tpm: TPM 1.2 support
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 09:36:50 -0500
Message-Id: <1144679810.4917.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set contains numerous changes to the base tpm
driver (tpm.c) to support the next generation of TPM chips.  The changes
include new sysfs files because of more relevant data being available, a
function to access the timeout and duration values for the chip, and
changes to make use of those duration values. Duration in the TPM
specification is defined as the maximum amount of time the chip could
take to return the results. Commands are in one of three categories
short, medium and long. Also included are cleanups of how the commands
for the sysfs files are composed to reduce a bunch of redundant arrays. 

The patches in this set have been updated to include the comments posted
to the first set.  The whole set will also need Marcel Selhorst's
tpm_infineon patch (http://marc.theaimsgroup.com/?l=linux-
kernel&m=114432147318726&w=2)in order for that module to build with
these changes.  It can be applied anywhere in the order as they do not
change any files in common 

Thanks,
Kylie


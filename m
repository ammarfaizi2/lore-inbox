Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269410AbUJSNzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269410AbUJSNzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbUJSNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 09:55:17 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:52156 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269411AbUJSNzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 09:55:03 -0400
Subject: Re: [BK PATCH] SCSI updates for 2.6.9
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Collins <bcollins@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, willy@debian.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
References: <1098137016.2011.339.camel@mulgrave>
	<200410182341.13648.dtor_core@ameritech.net>
	<200410190012.28071.dtor_core@ameritech.net> 
	<Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Oct 2004 08:54:43 -0500
Message-Id: <1098194090.1714.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 02:13, Linus Torvalds wrote:
>  does this look ok to you?
> 
> Arguably the SCSI layer should also have proper prefixes for its constants
> - and in fact they do kind of exist as the GPCMD_xxx constants.  Oh, well.
> Regardless, the sbp2 constants do look like they want prefixing..

We're slowly standardising at least some of our namespace problems.

The condition codes are all migrating to SAM_STAT_ prefix, so
CHECK_CONDITION becomes SAM_STAT_CHECK_CONDITION (and gets shifted in
the process).

We still have a nasty namespace pollution problem on the SCSI commands
though and cleaning this up is problematic since they permeate not just
SCSI but large areas of other drivers as well.

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUCaFnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 00:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUCaFns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 00:43:48 -0500
Received: from fmr05.intel.com ([134.134.136.6]:4069 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261745AbUCaFnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 00:43:47 -0500
Subject: Re: Status of ACPI PIC mode patches ?
From: Len Brown <len.brown@intel.com>
To: sezero@superonline.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6D64@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6D64@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080711812.3337.305.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2004 00:43:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 04:35, O.Sezer wrote:
> Hello:
> [Please CC me on replies]
> 
> What is the status of PIC mode patches [1] by Andrew de Quincey;
> are they still needed? The -ac / -pac trees still have them.

If the 1st one is needed, I want to know about it.
The 2nd and 3rd have been in for a long time.

> [1] http://marc.theaimsgroup.com/?t=106280426300001&r=1&w=2
> Also see:

This is Andrew's PIC-fallback patch.  This is probably
the most effective and well written patch that I've
refused to integrate;-)  There are two reasons.
1. it works for some systems, but breaks others.
2. when it works, it hides a failure.  Windows doesn't
have that failure.  We'd rather see the failure, fix it
and have Linux work as well as Windows.

BTW. SuSE picked up this patch in SL9.0, though I don't
know if they still use it.
 
> http://marc.theaimsgroup.com/?t=106280426300002&r=1&w=2

This has been in the base for about 5 months.  But
Luming Yu found a better way to handle this issue and
his patch was integrated into 2.4 and 2.6 in the
last week:
http://bugzilla.kernel.org/show_bug.cgi?id=1590

We'll probably delete the original retry code
in an upcoming cleanup.

> http://marc.theaimsgroup.com/?t=106280426100003&r=1&w=2

This patch by Jun Nakajima was pulled into the base
about 5 months ago.  It was key to getting VIA systems
to work.

cheers,
-Len



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTDRVTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTDRVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:19:04 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:16403
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263253AbTDRVTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:19:03 -0400
Subject: Re: mknod64(1)
From: Robert Love <rml@tech9.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b7pqf5$kqv$1@cesium.transmeta.com>
References: <1050700383.745.48.camel@localhost>
	 <b7pqf5$kqv$1@cesium.transmeta.com>
Content-Type: text/plain
Message-Id: <1050701464.745.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 18 Apr 2003 17:31:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-18 at 17:24, H. Peter Anvin wrote:

> Well, actually, once glibc is updated to call SYS_mknod64 and have the
> right MAJOR() and MINOR() macros, it shouldn't require any changes to
> mknod(1).

Agreed.  Assuming mknod(1) is dev_t-clean, this is obsolete as soon as
glibc is updated for 64-bit dev_t.  Until then, this is available and
easy and works.

> What would probably be useful for mknod(1), if it doesn't already, is
> to allow the major/minor to be specified in any of the standard bases,
> i.e. using strtoul(...,...,0).

mknod(1) does not, I think.  Actually, maybe it does... it uses some
coreutils wrapper.

But my mknod64(1) certainly does :)

Hex, decimal, and binary should all work.

	Robert Love


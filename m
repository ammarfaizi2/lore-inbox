Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUDBTdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUDBTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:33:15 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:47763 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264124AbUDBTdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:33:11 -0500
Date: Fri, 2 Apr 2004 14:29:44 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.4: disabling SCSI support not possible
In-Reply-To: <20040402144216.A12306@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.33.0404021418140.10369-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Russell King wrote:
>usb-storage should depend on SCSI rather than forcing SCSI to be
>enabled.

Actually, it should "require" SCSI, but the kernel configuration logic
does not support that.

>Using 'select' is all very well for the case where the target
>configuration symbol is not user selectable, but in the case that
>it is, it leads to the confusion shown above.

Indeed.  "select" is very useful for enabling options that cannot otherwise
be enabled.  However, it gets mis-applied in cases like this to address the
"stupid user" problem. (see above re: missing "require")  In fact, the
only place I can forgive the use of select on user selectable options in
within the input layer options -- select is used to force a valid usable
configuration instead of letting someone compile a kernel without any
keyboard support, BUT, it's still user tunable if "embedded" is enabled.

--Ricky

(see also: http://bk.troz.com:14690/linux-2.6-bk/user=jfbeam/cset@1.1396
 for additional SELECT removals.)



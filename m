Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTJUDcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 23:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJUDcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 23:32:47 -0400
Received: from fmr03.intel.com ([143.183.121.5]:19622 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262865AbTJUDcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 23:32:45 -0400
Subject: Re: [PATCH][2.4] fix "pci=noacpi" boot option
From: Len Brown <len.brown@intel.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310142328.59083.schlicht@uni-mannheim.de>
References: <200310142328.59083.schlicht@uni-mannheim.de>
Content-Type: text/plain
Organization: 
Message-Id: <1066707154.2904.89.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2003 23:32:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 at 17:28, Thomas Schlichter wrote:
> Hi Len,
> 
> some time ago I sent a patch which fixed problems with the "pci=noacpi" boot 
> option of the 2.5.xx linux-kernel. It got applied to the 2.5 kernel tree but 
> I missed to create a similar fix for the 2.4 tree which seems to have the 
> same issue.
> 
> Now I've seen reports of people having problems with the "pci=noacpi" boot 
> option with current 2.4.xx kernel versions, too. So I ported my old patch to 
> 2.4.22-bk34, tested it and attached it to this mail. You may consider pushing 
> it to Marcelo.
> 
> Kind regards,
>   Thomas

Thanks for the reminder Thomas, you're correct that pci=noacpi is
broken, see http://bugzilla.kernel.org/show_bug.cgi?id=1219

Note that pci=noacpi is a bug workaround.
It is a bug when a platform requires it.  The bug should be filed, root
caused, and fixed.  If you know of such platforms, please be encouraged
to file bugs with the details so we can get to the bottom of it.

thanks,
-Len

ps. #include std-acpi-interrupt-bug-info-reqeust.h

Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.



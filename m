Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbTCaXts>; Mon, 31 Mar 2003 18:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTCaXts>; Mon, 31 Mar 2003 18:49:48 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:62954 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S261928AbTCaXtq>;
	Mon, 31 Mar 2003 18:49:46 -0500
To: linux-kernel@vger.kernel.org
References: <7C078C66B7752B438B88E11E5E20E72E0EF78D@GENERAL.farsite.co.uk>
Subject: Generic HDLC update for 2.4.21-pre6, 2.4.21pre5-ac3, 2.5.66
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Apr 2003 02:00:41 +0200
Message-ID: <m3istzf5na.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kevin Curtis <kevin.curtis@farsite.co.uk> writes:

> Hi Marcelo,
> 	what about the Generic HDLC patch?   Please please please can we
> have it in 2.4.21?  I am sure others would like to see it there too.

I've put the updated HDLC patch (against 2.4.21pre6) in:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.4.21pre6.patch.gz

against 2.4.21-pre5-ac3:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.4.21pre5-ac3.patch.gz

against 2.5.66 (this is, of course, a little different):
ftp://ftp.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.5.66.patch.gz

Tested on all hardware I've access to (C101 and N2) on 2.4 and 2.5 kernels.

No much changes from previous release (the one in Alan's 2.4 tree): my (low
level) drivers have now smaller TX packet rings to decrease TX latency for
high priority packets (LMI etc), and there is only one RAM-sizing routine
for both cards (as well as for drivers not included in the official tree).

The code has been cleaned a bit.
kmalloc(GFP_KERNEL) in interrupt context has been fixed.
Some __init etc fixes.
No ABI/API changes.

Marcelo, please apply to 2.4.21-pre6,
Alan, please apply to 2.4.21-pre5-ac3,
Linus, please apply to 2.5.66.

Thanks.
-- 
Krzysztof Halasa
Network Administrator

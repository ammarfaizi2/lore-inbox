Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTGKTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTGKTEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:04:32 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:63647 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265100AbTGKTDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:03:19 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk>
	<Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
	<003101c34712$a9b8f480$602fa8c0@henrique>
	<1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Jul 2003 20:00:32 +0200
In-Reply-To: <1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m3of01djun.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> 2.4.21 has much older code than the current stuff (which has been in -ac
> for a while). As I understand it the new hdlc layer needs newer tools ?

Yes, this is the same new tool that is required for plain 2.4.21 and -ac
and for the last patch as well (not yet applied by you, BTW it's
http://hq.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre5-ac3-1.14.patch
or ftp:// the same, production-tested = you can apply it safely).
2.4.20 used older sethdlc tool but in practice all users were already
using the newer tool + kernel patch.

The last patch (1.14) contains few small bug-fixes and new Ethernet framing
for HDLC and FR. There are no incompatible ABI changes (i.e. older
sethdlc binary works with new kernels, but you of course need new tool for
new features) after the "big" switch in 2.4.21pre.
-- 
Krzysztof Halasa
Network Administrator

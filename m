Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTDREdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTDREdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:33:39 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:17169 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S262849AbTDREdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:33:38 -0400
Date: Fri, 18 Apr 2003 06:44:54 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: My P3 runs at.... zero Mhz (bug rpt)
Message-ID: <20030418044454.GA5349@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <3E9F5EAD.2070006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9F5EAD.2070006@pobox.com>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Thu, Apr 17, 2003 at 10:10:53PM -0400
> Just booted into 2.5.67-BK-latest (plus my __builtin_memcpy patch). 
> Everything seems to be running just fine, so naturally one must nitpick 
> little things like being told my CPU is running at 0.000 Mhz.  :)
> 
fwiw, my Athlon XP2400 does the same in 2.5.67-ac1:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) XP 2400+
stepping	: 1
cpu MHz		: 0.000
cache size	: 256 KB
bogomips	: 1970.17

Interesting enough, even the bogomips have halved w.r.t. earlier 2.5.x
kernels and 2.4.2x kernels. Booting a 2.4.21-pre7 kernel on the same
machine gets me close to 4000 bogomips, as is proper for a 2 GHz cpu.

The ioapic code does report the correct bus-speed however.

Ah well, they were bogus to begin with.
-- 
"I am not to be trifled with!"
"I didn't bring a trifle," Hawk said to Fisher. "Did you think to
bring a trifle?" "Knew I forgot something," said Fisher.
	Simon R Green - Beyond the Blue Moon
Debian (Unstable) GNU/Linux 2.5.67-ac1 1970 bogomips load av: 1.48 1.62 1.79

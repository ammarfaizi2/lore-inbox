Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTH0JAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTH0JAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:00:25 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:35224 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263229AbTH0JAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:00:22 -0400
Date: Wed, 27 Aug 2003 11:00:20 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030827090020.GC9054@merlin.emma.line.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org> <20030722205629.GA27179@gtf.org> <20030722213926.GA4295@codepoet.org> <3F4C1F09.846A83EF@vtc.edu.hk> <3F4C2210.6050404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4C2210.6050404@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Jeff Garzik wrote:

> For the future, I'm currently whipping the libata internals into shape 
> so that Promise may be supported.  Promise hardware supports native 
> command queueing, a lot like many SCSI adapters.

Is that true even for the older stuff such as a PDC20265?

It appears that FreeBSD 4-STABLE blacklists some older (before-TX2)
Promise chips because they apparently lock up when used with tagged
command queueing. I haven't yet looked at the ATAng driver merged into
FreeBSD 5-CURRENT.

FreeBSD 4-STABLE blacklist code in function ad_tagsupported():
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/ata-disk.c?rev=1.60.2.24&content-type=text/x-cvsweb-markup&only_with_tag=RELENG_4

FreeBSD 5-CURRENT:
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/

-- 
Matthias Andree

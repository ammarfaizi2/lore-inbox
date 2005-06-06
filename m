Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFFKva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFFKva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFFKva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:51:30 -0400
Received: from main.gmane.org ([80.91.229.2]:27306 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261281AbVFFKv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:51:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David =?utf-8?b?QmFsYcW+aWM=?= <david.balazic@hermes.si>
Subject: Boot  problems & zero page Was: [PATCH] Increase number of e820 entries hard limit from 32 to 128
Date: Mon, 6 Jun 2005 10:45:29 +0000 (UTC)
Message-ID: <loom.20050606T123409-328@post.gmane.org>
References: <20050422181441.A18205@unix-os.sc.intel.com> <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org> <20050422193250.A18512@unix-os.sc.intel.com> <20050423151048.GE7715@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.253.102.145 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak <at> suse.de> writes:

> The last time I tried to extend the zero page (with a longer command line)
> it broke lilo on systems with EDID support and CONFIG_EDID enabled.
> Make sure you test that case.

Hi!

I (and other) had problems, that may be related to this. Can you look into it ?

What happened was :
linux boot had a delay of 10..30..90..infinite seconds, depending on command
line length and certain disk related BIOS settings.
GRUB was the loader. The delay went away after disabling CONFIG_EDD.
It was also "fixed" by downgrading the BIOS version.

It would be really cool if you could inject some wisdom in the issue ;-)

For details, see the LKML archives :

"EDD code causes long boot delay"
<http://marc.theaimsgroup.com/?t=108788699100001&r=1&w=2>

"[PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR"
<http://lkml.org/lkml/2004/10/4/239>

"[PATCH 2.6] EDD: add edd=off and edd=skipmbr options"
<http://lkml.org/lkml/2004/11/23/293>

Kind regards,
David Balazic


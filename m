Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUH0JIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUH0JIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUH0JDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:03:15 -0400
Received: from aun.it.uu.se ([130.238.12.36]:55235 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269312AbUH0JCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:02:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.63645.385326.3389@alkaid.it.uu.se>
Date: Fri, 27 Aug 2004 11:02:21 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Hugh Dickins <hugh@veritas.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1 Latitude APM suspend freeze
In-Reply-To: <Pine.LNX.4.44.0408261949110.3367-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0408261949110.3367-100000@localhost.localdomain>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
 > Been suffering APM suspend freezes with 2.6.9-rc1 on Dell Latitude C610.
 > Now found that you have removed local_apic_kills_bios(),
 > which existed precisely to protect against that.

As the original author of the local_apic_kills_bios() code,
I have no idea why it was removed. Lots of Dell Latitude and
Inspiron BIOSen hang hard with local APIC.

As a workaround, you can boot with "nolapic".

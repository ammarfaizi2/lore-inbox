Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUJZIms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUJZIms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUJZIms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:42:48 -0400
Received: from canuck.infradead.org ([205.233.218.70]:9490 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262180AbUJZImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:42:44 -0400
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
	for suspend/resume
From: Arjan van de Ven <arjan@infradead.org>
To: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Li, Shaohua" <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <417DEA8D.4080307@intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026051100.GA5844@wotan.suse.de>  <417DEA8D.4080307@intel.com>
Content-Type: text/plain
Message-Id: <1098780150.2789.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 26 Oct 2004 10:42:31 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 02:11 -0400, Len Brown wrote:
> What this comes down to is that extended config space is device-specific.
> Generic solutions will fail.  Only device drivers will work.
> 
> If there are no drivers for PCI bridges to properly save/restore
> their config space, then should create them, even if this is all the 
> drivers do.

note that by default, if there is no driver, the first 64 bytes of
config space are saved/restored.
-- 


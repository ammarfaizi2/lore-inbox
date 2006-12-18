Return-Path: <linux-kernel-owner+w=401wt.eu-S1753864AbWLRLl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbWLRLl1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbWLRLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:41:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57747 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbWLRLl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:41:26 -0500
Subject: Re: Linux disk performance.
From: Arjan van de Ven <arjan@infradead.org>
To: Manish Regmi <regmi.manish@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 18 Dec 2006 09:35:39 +0100
Message-Id: <1166431020.3365.931.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Can we achieve smooth write times in Linux?

if you want truely really smooth writes you'll have to work for it,
since "bumpy" writes tend to be better for performance so naturally the
kernel will favor those.

to get smooth writes you'll need to do a threaded setup where you do an
msync/fdatasync/sync_file_range on a frequent-but-regular interval from
a thread. Be aware that this is quite likely to give you lower maximum
performance than the batching behavior though.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


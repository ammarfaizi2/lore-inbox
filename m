Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUCHGax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCHGax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:30:53 -0500
Received: from palrel12.hp.com ([156.153.255.237]:39138 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262406AbUCHGaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:30:52 -0500
Date: Sun, 7 Mar 2004 22:30:44 -0800
From: Grant Grundler <iod00d@hp.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
Message-ID: <20040308063044.GB25960@cup.hp.com>
References: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 11:49:10AM +0900, Kenji Kaneshige wrote:
> In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are unmasked at the
> boot time before installing device drivers. I think it is very dangerous.

Hi Kenji,
I think this behavior exists to support "legacy" IRQ probing.
I'm wondering if it would be sufficient to wrap the patch in
"#ifndef CONFIG_ISA" or something like that.

grant

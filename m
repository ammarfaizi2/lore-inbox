Return-Path: <linux-kernel-owner+w=401wt.eu-S932340AbXAISfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbXAISfg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbXAISfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:35:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59962 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXAISff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:35:35 -0500
Date: Tue, 9 Jan 2007 10:35:30 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Dmitriy Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5]  fixing errors handling during pci_driver resume
 stage [net]
Message-ID: <20070109103530.2f10f823@freekitty>
In-Reply-To: <87vejgmv51.fsf@sw.ru>
References: <87vejgmv51.fsf@sw.ru>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2007 12:01:14 +0300
Dmitriy Monakhov <dmonakhov@openvz.org> wrote:

> network pci drivers have to return correct error code during resume stage in
> case of errors.
> Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
> -----

Please don't introduce one dev_err() call into a device driver if all the other
error printout's use a different interface.

-- 
Stephen Hemminger <shemminger@osdl.org>

Return-Path: <linux-kernel-owner+w=401wt.eu-S965073AbWLTOE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWLTOE3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWLTOE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:04:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37973 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965073AbWLTOE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:04:28 -0500
Subject: Re: [PATCH 4/10] cxgb3 - HW access routines - part 2
From: Arjan van de Ven <arjan@infradead.org>
To: divy@chelsio.com
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
In-Reply-To: <200612201242.kBKCgaVU006331@localhost.localdomain>
References: <200612201242.kBKCgaVU006331@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 15:04:19 +0100
Message-Id: <1166623459.3365.1399.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +void t3_port_intr_disable(struct adapter *adapter, int idx)
> +{
> +	struct cphy *phy = &adap2pinfo(adapter, idx)->phy;
> +
> +	t3_write_reg(adapter, XGM_REG(A_XGM_INT_ENABLE, idx), 0);
> +	phy->ops->intr_disable(phy);

you seem to be missing a pci posting flush here....



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVHVUWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVHVUWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVHVUWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:22:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5255
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751023AbVHVUWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:22:35 -0400
Date: Mon, 22 Aug 2005 13:22:21 -0700 (PDT)
Message-Id: <20050822.132221.43661966.davem@davemloft.net>
To: davej@redhat.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, mlindner@syskonnect.de,
       akpm@osdl.org
Subject: Re: skge missing ifdefs.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050822195913.GF27344@redhat.com>
References: <20050801203442.GD2473@redhat.com>
	<20050801203818.GA7497@havoc.gtf.org>
	<20050822195913.GF27344@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Mon, 22 Aug 2005 15:59:13 -0400

> This is still broken afaics in todays -git.

They are certainly there in Linus's current GIT tree.

 ...
#ifdef CONFIG_PM
static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
 ...
static int skge_resume(struct pci_dev *pdev)
 ...
#endif
static struct pci_driver skge_driver = {
 ...
#ifdef CONFIG_PM
	.suspend = 	skge_suspend,
	.resume = 	skge_resume,
#endif
};

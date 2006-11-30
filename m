Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967791AbWK3BWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967791AbWK3BWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967793AbWK3BWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:22:50 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:53903 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967791AbWK3BWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:22:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LUUfq4o1U+4LflM+UEwa4KOkdbljVnDfMcDIIEynxveK+zt0FOerxqln861TyohuXYh8B4e1iQmTHriYi+mff6YjYuePslHhZPm0kk6/JOJWYbi8Z5nRXb2OCU1Q3BR91L4tYrglEDnPyOYGEJ3gbXWA023hlORysNYPJcDKXaA=;
X-YMail-OSG: 0ucpLlkVM1mFJ56VADkpe6vbUtjSPvKDfAfKRahK2AlfKLsSdFCIf.48yYjPw1_mokirIIhDF76VLNbja9THpca9GQV_PMQpCXYqbcg8ZSFwlnyiXb3Y2dhWJvSOfEnaAMBRan7luGXpXi2IuYyAOHugrNpfBnye
Date: Wed, 29 Nov 2006 17:22:48 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Infinite retries reading the partition table
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <617182.73467.qm@web31807.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose reading sector 0 always reports an error,
sense key HARDWARE ERROR.

What I'm observing is that the request to read sector 0,
reading partition information, is retried forever, ad infinitum.

Does anyone have a patch to resolve this? (2.6.19-rc6)

Thanks,
    Luben


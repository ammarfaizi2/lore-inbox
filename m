Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWGXSys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWGXSys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWGXSys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:54:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21475
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932290AbWGXSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:54:47 -0400
Date: Mon, 24 Jul 2006 11:54:56 -0700 (PDT)
Message-Id: <20060724.115456.17862176.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2 () on SPARC64: Compile failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607241325.k6ODPnTW003266@laptop13.inf.utfsm.cl>
References: <200607241325.k6ODPnTW003266@laptop13.inf.utfsm.cl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Mon, 24 Jul 2006 09:25:49 -0400

> I'm getting:
> 
>   CC [M]  drivers/scsi/esp.o
>   drivers/scsi/esp.c: In function `esp_should_clear_sync':
>   drivers/scsi/esp.c:2758: error: structure has no member named `data_cmnd'
>   make[2]: *** [drivers/scsi/esp.o] Error 1
>   make[1]: *** [drivers/scsi] Error 2
>   make: *** [drivers] Error 2

Known problem, the scsi maintainers removed a member from a
common structure and this broke the build of a few drivers.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVGBRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGBRBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGBRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:01:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:31398 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261194AbVGBRBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:01:34 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120322788.22046.2.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 13:01:31 -0400
Message-Id: <1120323691.5073.12.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 17:46 +0100, Tony Vroon wrote:
> What does that asynchronous line mean? I  see that on all kernels that
> do not boot properly. 2.6.12; 2.6.12.1 and 2.6.12.2 do not display it,
> and boot just fine.
> 
> target0:0:0: asynchronous

It means the target is sending data asynchronously (the slowest and
safest speed).

Could you try booting with aic7xxx=verbose to see what the device thinks
its negotiating?

Thanks,

James



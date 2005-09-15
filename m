Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVIOUNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVIOUNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVIOUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:13:37 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:15784 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S1030492AbVIOUNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:13:36 -0400
Message-ID: <61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <1126790860.19133.75.camel@localhost.localdomain>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com>
    <1126790860.19133.75.camel@localhost.localdomain>
Date: Thu, 15 Sep 2005 17:13:11 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, izvekov@lps.ele.puc-rio.br,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ata_interrupt checks qc->tf.ctl & ATA_NIEN
>
> Other functions set/reset nIEN in the tf they issue then directly call
> ata_tf_load/ata_exec_* so I don't believe qc->tf.ctl is the correct
> thing to check for non-interrupt status on older type controllers at
> least.
>
> Instead you need to look at ap->last_ctl. But that too looks suspect if
> any kind of reset sets it back to an undefined state.
>

Just tried that, and it doesnt help. Doesnt change behaviour, at least for
my problem.

> Finally I don't see what locks viewing ->tf.ctl/->last_ctl against
> whether it has yet been loaded into the hardware.
>
> Alan
>

Thanks.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTADJnF>; Sat, 4 Jan 2003 04:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTADJnF>; Sat, 4 Jan 2003 04:43:05 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:65184 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266765AbTADJnE>; Sat, 4 Jan 2003 04:43:04 -0500
Subject: Re: [PATCH] Make ide-probe more robust to non-ready devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1041673277.1346.29.camel@zion.wanadoo.fr>
References: <1041672876.1346.23.camel@zion.wanadoo.fr>
	 <1041673277.1346.29.camel@zion.wanadoo.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1041674038.1346.36.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 10:53:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
> + * Code below should be made generic, see comment near call of
> + * wait_hwif_ready() in probe_hwif()
> + */
> +static int wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)

Obviously, you can ignore that comment ;) It dates from a time that
code was shielded in #ifdef CONFIG_ALL_PPC...

Ben.



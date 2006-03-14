Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWCNNL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWCNNL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWCNNL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:11:27 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:57783 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751916AbWCNNL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:11:27 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/stderr gets unlinked 8]
Date: Tue, 14 Mar 2006 14:11:09 +0100
User-Agent: KMail/1.9.1
References: <200603141213.00077.vda@ilport.com.ua>
In-Reply-To: <200603141213.00077.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141411.11121.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> In the bad days of devfsd, no user program could remove /dev/stderr
> (bacause fs didn't allow for that).
>
> But I switched to udev sometime ago.
>
> Today I discovered that my mysqld was happily unlinking it and
> recreating as regular file in /dev (I pass --log=/dev/stderr
> to mysqld).
>
> Can I make /dev/stderr non-unlink-able?
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

You could run mysql as non-privileged user or try something like 
--log=/proc/self/fd/2

-Christian

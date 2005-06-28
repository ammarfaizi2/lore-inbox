Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVF1LC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVF1LC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVF1LC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261305AbVF1LCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:02:45 -0400
Date: Tue, 28 Jun 2005 03:58:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: variable used before set
Message-Id: <20050628035853.3470e420.akpm@osdl.org>
In-Reply-To: <BAY19-F35B8A38C4A94BA62F2B5139CE10@phx.gbl>
References: <BAY19-F35B8A38C4A94BA62F2B5139CE10@phx.gbl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Add linux-scsi)

"d binderman" <dcb314@hotmail.com> wrote:
>
> Hello there,
> 
> I just tried to compile the Linux Kernel version 2.6.11.12
> with the most excellent Intel C compiler. It said
> 
> drivers/scsi/pcmcia/aha152x_stub.c(313): remark #592: variable "tmp" is used 
> before its value is set
>         tmp.device->host = info->host;
>         ^
> 
> This is clearly broken code, since the field tmp.device has not been
> initialised, and so isn't pointing to anything.
> 
> Suggest code rework.

Yup, that will crash.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVAaWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVAaWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVAaWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:14:22 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:14776 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbVAaWNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:13:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YE0PXQlQs8sRG4oz9Ila+nfRHLQURd7Z4d/Yof8Rw5RhxiNhu31D6TtUofz7Ig/vbAgKLL47/j+FRXELtZoZqdxztt/7UFbkst6sZNWvWZPIHEu826cM1etKW7e3JKMaWTxr0h08A7Zy8DMzDzyc/EU4SivfMy49aOXrGfF7IgM=
Message-ID: <d120d500050131141358ff63c9@mail.gmail.com>
Date: Mon, 31 Jan 2005 17:13:22 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
In-Reply-To: <20050131214905.GF28886@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131173508.GS18316@stusta.de>
	 <20050131214905.GF28886@deep-space-9.dsnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 22:49:05 +0100, Stelian Pop <stelian@popies.net> wrote:
> 
> sonypi.h is a "local" header file used only by sonypi.c.
> 
> I would like to keep those tables in sonypi.h rather than putting
> all into sonypi.c (or we could as well remove sonypi.h and put all the
> contents into the .c).
> 

Hi,

What is the point of having an .h file if it is not used by anyone?
Judging by the fact that it completely protected by #ifdef __KERNEL__
there should be no userspace clients either.

I always thought that the only time .h is needed is when you define
interface to your code. I'd fold it to sonpypi.c.

-- 
Dmitry

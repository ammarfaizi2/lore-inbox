Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVANW2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVANW2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVANWZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:25:43 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:25013 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262198AbVANWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:19:35 -0500
Date: Sat, 15 Jan 2005 01:41:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, Michal Ludvig <michal@logix.cz>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
 at a time
Message-ID: <20050115014130.2dcd3f2e@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050115013103.05698f1a@zanzibar.2ka.mipt.ru>
References: <20050115013103.05698f1a@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005 01:31:03 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> 
> Crypto routing.
> This feature allows the same session to be processed by several devices/algorithms. 
> For example if you need to encrypt data and then sign it in TPM device you can create 
> one route to encryption device and then route it to TPM device. (Note: this feature 
> must be discussed since there is no time slice after session allocation, only in 
> crypto_device->data_ready() method and there are locking issues in ->callback() method).

Actually it is already impleneted by 
crypto_session_alloc();
route manipulations
crypto_session_add();

And sessions can be (re)routed inside crypto devices itself.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

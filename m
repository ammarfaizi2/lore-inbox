Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbVCDNYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVCDNYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVCDNWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:22:53 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:16469 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262919AbVCDNRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:17:44 -0500
Message-ID: <42285FF7.2040906@tls.msk.ru>
Date: Fri, 04 Mar 2005 16:17:43 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: se go <ass22@inbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP ACKs carrying data
References: <E1D7CFT-000N35-00.ass22-inbox-ru@f24.mail.ru>
In-Reply-To: <E1D7CFT-000N35-00.ass22-inbox-ru@f24.mail.ru>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

se go wrote:
> Hello,
> 
> i got some problems concerning tcp realization in kernel (v 2.4).
> 
> i need to make some modifications to tcp to be able to transfer data within ACK segments...(initially their data field is empty)

I thought it is already here.  That is, if the kernel have something
to send at the moment when incoming packet arrives, it sends one
packet out, containing both the ACK for previously received packet
and the data.

Ie, if the app is sending data in both directions, there will be no
(well, almost: initial handshake and final sequence are still unique)
"bare" ACKs, or packets without data.

Or Am I just dreaming? ;)

/mjt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVEWSfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVEWSfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEWSfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:35:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38601 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261929AbVEWSec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:34:32 -0400
Message-ID: <42922232.90206@pobox.com>
Date: Mon, 23 May 2005 14:34:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Ivan G <g-i-v@rambler.ru>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
References: <web-135595327@mail5.rambler.ru> <20050523193010.5bf72481.vsu@altlinux.ru>
In-Reply-To: <20050523193010.5bf72481.vsu@altlinux.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> To IDE developers: Is something planned to work around this problem?
> AFAIK, there are some machines where BIOS does not provide an option to
> turn off the combined mode.

This limitation exists because two drivers (drivers/ide and libata) want 
to use different parts of the same hardware.

Once libata can do ATAPI 100%, when we can just let libata handle both 
PATA and SATA, which will enable DMA again.

	Jeff



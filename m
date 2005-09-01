Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVIALjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVIALjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVIALjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:39:22 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:61103 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965031AbVIALjW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:39:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GIzLE838KD4Wn+JdSfJxc3URIvHfy9rkbKe6HvFwiMf1UxkKtm0bzt/eu6pMB+REzd+wVQUchMa1IE71zuaNyLZpnw+JYCQ780r2NLR3tt9kyEdXKo3ne5+bOMaWukR0BHRCvvGDV8Ji7zFXTUcb8T63sLPIs5LRgYKLEPCbUHU=
Message-ID: <cda58cb8050901043967808e00@mail.gmail.com>
Date: Thu, 1 Sep 2005 13:39:19 +0200
From: Franck xyz <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Help on HCD developpement
In-Reply-To: <cda58cb8050901025311665d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb8050901025311665d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a host controller driver for a Arc hardware. I
need to know how nak
pid should be handled ? Hardware can automatically manage them, that means it
automatically retry the naked transaction. But since setup packet must
not be "NAKed" or hub
endpoint #1 returns nak pid when no events happen on its port, I don't
think I can use this
feature. But if I do it manually, what should I do when receiving a
NAK ? Should I retry the
transaction forever ? What status should I return to usb core (through
urb->status) when hub
endpoint #1 returns nak ?

Thanks.
               Franck

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVGLRBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVGLRBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVGLRBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:01:05 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:37445 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261587AbVGLRA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Tn9LeffyWuCFxJiwE1+jqOlz3gzmio8WYvWzCfY0EgPp3zfvSvAuP26JGD2QtzZm+dRg/ZxMQaQ6URq2Pnu2Rh058sCCDE0eyuFTW3L1Rz+UVS5UwVP9FpqCQa6K28SadOxOy4k9zgk6hZ1Wj2Kn4u6foX/MhJDaK3IH72hDrgo=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Krufky <mkrufky@m1k.net>
Subject: Re: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
Date: Tue, 12 Jul 2005 21:07:51 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
References: <42D3DC5A.3010807@m1k.net>
In-Reply-To: <42D3DC5A.3010807@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122107.51907.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 19:06, Michael Krufky wrote:
> v4l-saa7134-hybrid-dvb.patch
> v4l-cx88-update.patch
> 
> The specific change that caused this problem is:
> 
> - Let Kconfig decide whether to include frontend-specific code.
> 
> I had tested this change against 2.6.13-rc2-mm1, and it worked perfectly as
> expected, but it caused problems in today's 2.6.13-rc2-mm2 release.  For
> some reason, the symbols don't get set properly.

What symbols? What error messages do you see?

> --- linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c
> +++ linux/drivers/media/video/cx88/cx88-dvb.c

> +#define CONFIG_DVB_MT352 1
> +#define CONFIG_DVB_CX22702 1
> +#define CONFIG_DVB_OR51132 1
> +#define CONFIG_DVB_LGDT3302 1

> --- linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c
> +++ linux/drivers/media/video/saa7134/saa7134-dvb.c

> +#define CONFIG_DVB_MT352 1
> +#define CONFIG_DVB_TDA1004X 1

Looks band-aidly.

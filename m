Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWD0CLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWD0CLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWD0CLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:11:45 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:39151 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964877AbWD0CLp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:11:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AfQUW5B4Xz+BhWrmWkshc2xehe/VA+/VoLPaVWpTd6aK9kl32Du4p89CDKKGlpq5jhzXvULaG5oGpQewsfaYVZncePnQf/Go7FkbUINsyjrOu/KSi0Ie+nR0bvjEYjZhNfM8tdPhelc5klVDCQQuoQ8ul8PJmaKiga3wGt5uzp0=
Message-ID: <84d7d9cf0604261911m46cd505fxd9fc2045d687c79f@mail.gmail.com>
Date: Thu, 27 Apr 2006 10:11:44 +0800
From: "Real Oneone" <realoneone@gmail.com>
To: "David G." <kiddion@zonnet.nl>
Subject: Re: How to re-send out the packets captured by my hook function at NF_IP_PRE_ROUTING
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <444F91F8.80809@zonnet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <65RDw-7AC-33@gated-at.bofh.it> <444F91F8.80809@zonnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks, David!

I've read what you mentioned and since I've done most of the work in
kernelspace, I wonder if there is any way to send out the modified
packet directly, when of course the mac address is not filled?

Thanks again!

2006/4/26, David G. <kiddion@zonnet.nl>:
> Real Oneone wrote:
> > Hi, I plugged a callback function into netfilter at the hook point of
> > NF_IP_PRE_ROUTING, tring to capture all the packets, make
> > some changes to some of them, and invoke skb->dev->hard_start_xmit to
> > send them out directly. However, the kernel crashed before I could get
> > any printked information.
> >
> > If you have any idea of how to send the received packets out, please tell me.
>
> You might want to explore the possibilities of the existing "ip_queue"
> kernel extension instead, it was design to do packet
> capture/inspection/changing in userspace.
>
> FireFlier works that way ( http://fireflier.sourceforge.net/ ) and so
> does inlined snort (http://www.snort.org/docs/snort_manual/node7.html).
>
> You can take a look at:
> http://www.linuxia.de/netfilter.en.html#userspace and
> http://www.cs.princeton.edu/~nakao/libipq.htm for an example application.
>

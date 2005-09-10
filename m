Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVIJV1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVIJV1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIJV1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:27:39 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:9066 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932287AbVIJV1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:27:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rQ1NccDSUrDf0WkS6mPfI+gq0dp6LVW0+cHgiiVLMbFjijln2U5uGsgj6bBBWcR7cFP5jZb4x/YL8zi6ZJBp9dX7vsnfi8CSir9WbfoSQEvF5xTVZurcK2gODSQArEPl1UOc06mX6zSVTjXKYXv1I4lmcVLacxLRr5COgqlHejU=
Message-ID: <43234F91.8070801@gmail.com>
Date: Sun, 11 Sep 2005 05:26:41 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manuel Lauss <mano@roarinelk.homelinux.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org> <4322C741.9060808@roarinelk.homelinux.net> <4322D49D.5040506@pol.net> <4322E3A3.5010903@roarinelk.homelinux.net>
In-Reply-To: <4322E3A3.5010903@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss wrote:
> Console: switching to colour frame buffer device 80x25
> I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP)
> Framebuffer Device v0.9.0
> I810FB: Video RAM   : 4096K
> I810FB: Monitor     : H: 40-80 KHz V: 60-60 Hz
> I810FB: Mode        : 640x400-8bpp@69Hz
> 

One more thing, vfmin and vfmax are set to 60 and 60.  This does
not give a lot of room for the calculation.  It's possible that
the GTF might calculate for 59.9 Hz, but since calculation are done
in integers it returns as 59.

So, give a little room for vfmin and vfmax, such as 59 and 60.

Tony

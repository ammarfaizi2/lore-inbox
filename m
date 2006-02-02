Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWBBTiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBBTiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWBBTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:38:12 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:7792 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbWBBTiL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:38:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RKMVyenN4/0pTYew+eP3zFzN+QwkJVQ2Nd5bDFAXWQ9wRIy5aapJl/dLZhtqmZorMH/A2kt5eNM9Dq4XTMO+RjsDd2wik7UYGBO8noUC8Zf8xmTuN8VxtxXUCOQSHvtBQq5IJceFURCrYfZXHdsLuqJgome+IfBW4WGmGzfZpPo=
Message-ID: <9a8748490602021138h3b4b4432se1529101e5536ddc@mail.gmail.com>
Date: Thu, 2 Feb 2006 20:38:10 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
In-Reply-To: <20060202192414.GA22074@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060202192414.GA22074@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Dave Jones <davej@redhat.com> wrote:
> In the case where we detect a single bit has been flipped, we spew
> the usual slab corruption message, which users instantly think
> is a kernel bug.  In a lot of cases, single bit errors are
> down to bad memory, or other hardware failure.
>
> This patch adds an extra line to the slab debug messages in those
> cases, in the hope that users will try memtest before they report a bug.
>
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Single bit error detected. Possibly bad RAM. Please run memtest86.
>
May I suggest that the text be
 Single bit error detected. Possibly bad RAM. Please run memtest86
and/or memtest86+.

both programs are good memory testers, but they are different and
sometimes one finds problems not detected by the other.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

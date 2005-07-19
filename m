Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVGSAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVGSAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGSAw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:52:58 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:18227 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261758AbVGSAw5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:52:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=onwpqFxhkg3u0TI3II4BxpMSKlH6u89L01KRJcLELwQVEM+cz7X8nvurhjiR5oc87tjW663iLKdT4+BcBiyb+VDKtD5nDAy0ubt40tAvE7Y0cIl3EJfSe69MaPYAW7xxUXfmWjNybdMNhZ4lbgB5lcEB8U1r/5hruomfv5Tz3os=
Message-ID: <9a87484905071817525f98d66f@mail.gmail.com>
Date: Tue, 19 Jul 2005 02:52:28 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: art@usfltd.com
Subject: Re: 2.6.12.3 ompilation errors with linux1394.org rev.1315
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507181126.AA81068656@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507181126.AA81068656@usfltd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, art <art@usfltd.com> wrote:
> 
> 2.6.12.3 ompilation errors with linux1394.org rev.1315
> 
> [....]$ make && make modules

That's redundant, "make" implicitly does "make modules", so just
running "make" will do.

> ..........
> LD      drivers/ieee1394/built-in.o
>   CC [M]  drivers/ieee1394/ieee1394_core.o
> drivers/ieee1394/ieee1394_core.c: In function 'hpsbpkt_thread':
> drivers/ieee1394/ieee1394_core.c:1035: error: too few arguments to function 'try_to_freeze'

try_to_freeze() used to take a single argument, it doesn't any more -
looks like someone forgot to teach that to ieee1394_core.c. It seems
to be fixed in 2.6.13-rc3 though, so try that one.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWBPWIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWBPWIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWBPWIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:08:14 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:42580 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932567AbWBPWIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:08:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=neaBncVYFfdriGR7E4HO+flxDSldAJ8Z9cECCXiPkhIpC9kZeIrmKA/kIpefbZl2ITxvX5yaOnhSknFcu5vxrM/YKiXF79d5jLcbTig3otSWSdwTTU5HCSFlPacTpxR0xiL3lj44Bjb4/C64osbvyRM3vKr8kjHBAQ8suN7nkaY=
Message-ID: <9a8748490602161408i736a7ab3vef09f3e1c95916fe@mail.gmail.com>
Date: Thu, 16 Feb 2006 23:08:12 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Wrong number of core_siblings in sysfs for Athlon64 X2
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <200602162259.32433.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
	 <200602162259.32433.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Andi Kleen <ak@suse.de> wrote:
> On Thursday 16 February 2006 22:46, Jesper Juhl wrote:
>
> > Obviously something is wrong, but I just can't seem to spot it.  Any clues?
>
> It's a bitmap. 3 = 0b11
>

When I was reading the smpboot code my brain *was* actually in the
"this is a bitmap" mode, but when I then looked at the sysfs code it
for some reason switched to "this wants to just print the number of
siblings as an integer" mode - which was obviously where I went wrong.
If it's being treated as a bitmap when it's created why would that
change when it gets printed - D'OH!

Thank you very much for that hit with the clue stick Andi.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

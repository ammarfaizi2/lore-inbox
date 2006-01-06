Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWAFMPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWAFMPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWAFMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:15:13 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:14230 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751403AbWAFMPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:15:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Ja5yRn08iCXm2ZM1YO9tYrtUOk0gaB7+QWDt9oS8qcBFYWr6JCHz9pwVbVlepOgQeZLx86VEUU1IGqfJs+Xg0kbKzRusO2+KT2C2hVS+4WcwveBpFC8Z5LiSoifOQsaA1ew+H5No5bTyHn5GS16KYDZ00AOfdTEpxxALNWUae2k=
Date: Fri, 6 Jan 2006 14:15:09 +0200
From: Timo Hirvonen <tihirvon@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove gfp argument from kstrdup()
Message-Id: <20060106141509.01c66bf2.tihirvon@gmail.com>
In-Reply-To: <84144f020601060351g48f3ef5bqf25a2a1bf02af4e6@mail.gmail.com>
References: <20060105234253.758b126a.tihirvon@gmail.com>
	<84144f020601060351g48f3ef5bqf25a2a1bf02af4e6@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.0beta2 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 13:51:41 +0200
Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On 1/5/06, Timo Hirvonen <tihirvon@gmail.com> wrote:
> > All kstrdup() callers use GFP_KERNEL flag so this parameter seems to be
> > useless.
> 
> Please don't. You're making the API inconsistent and forcing everyone
> to use GFP_KERNEL for little or no benefit.

I don't see why any other GFP_* flag could be useful for strings.

-- 
http://onion.dynserv.net/~timo/

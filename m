Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUIFMSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUIFMSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUIFMSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:18:37 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:972 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267850AbUIFMSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:18:35 -0400
Date: Mon, 6 Sep 2004 05:17:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] removes unnessary print of space
Message-ID: <20040906121747.GA9113@taniwha.stupidest.org>
References: <413C0CC5.4000807@sw.ru> <20040906000826.73157de6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906000826.73157de6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 12:08:26AM -0700, Andrew Morton wrote:

> Until some smarty comes along and optimises printk() to skip empty
> strings.

define the bahavior to disallow that

> An explicit wake_up_klogd() thing might make sense, rather than
> relying upon side-effects.

what about something like:

#define wake_up_klogd() (printk(NULL))

then?  and have printk short-circuit where required when it gets NULL
but still wake the console up?


  --cw

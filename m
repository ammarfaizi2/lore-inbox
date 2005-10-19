Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVJSAdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVJSAdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJSAdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:33:32 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:45383 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932369AbVJSAdb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:33:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eM06s1IlXHQAdor0rym3aaTP/wphKROl7IbjvJ96Yje5v/BfvOWA+M7j7HT2/C5So6tqzVO9a6hfB9Idn8eHicHZ0v3sKiMK/f/xK7SDoDGPOJRFUwX1yXKh13xB9NqrPLUALBo5p4PifBlGEjb3hr0PmWwLkRQvHcscJUgD95k=
Message-ID: <1e62d1370510181733n131a4465j36531064551ef478@mail.gmail.com>
Date: Wed, 19 Oct 2005 05:33:30 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: large files unnecessary trashing filesystem cache?
Cc: 7eggert@gmx.de, Guido Fiala <gfiala@s.netic.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1129676753.23632.90.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it>
	 <E1ERzTq-0001IA-Ba@be1.lrz>
	 <1129676753.23632.90.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Badari Pulavarty <pbadari@gmail.com> wrote:
> On Tue, 2005-10-18 at 23:58 +0200, Bodo Eggert wrote:
> > Changing a few programs will only partly cover the problems.
> >
> > I guess the solution would be using random cache eviction rather than
> > a FIFO. I never took a look the cache mechanism, so I may very well be
> > wrong here.
>
> Read-only pages should be re-cycled really easily & quickly. I can't
> belive read-only pages are causing you all the trouble.
>

I don't think the file is marked read-only ... that is when it is
accessed for reading the cache will contain the new file data and the
previous cached data will be lost .... So how u can say that read-only
pages or read-pages are not causing the problem ??

And I think the large files trashing filesystem caching problem can be
handled by the application using direct I/O or that must and might
already be managed by the file-system it-self because I think besides
application and file-system there isn't any thing present which can
detect the file currently accessing is a large file (as underlying
layer deals with blocks of data, or at block level with sectors and u
can't say what kind of data it is) ....

Is I m correct ??? or missing something ??


--
Fawad Lateef

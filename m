Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVBSQyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVBSQyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVBSQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:54:08 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:52656 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261735AbVBSQxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:53:32 -0500
Message-ID: <42176EC4.8080700@keyaccess.nl>
Date: Sat, 19 Feb 2005 17:52:20 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Vicente Feito <vicente.feito@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
References: <200502190148.11334.vicente.feito@gmail.com>	<52is4ptae0.fsf@topspin.com> <42174DD4.9010506@keyaccess.nl> <52acq0ttdg.fsf@topspin.com>
In-Reply-To: <52acq0ttdg.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>     Rene> I have no idea about the module refcounting stuff. Is there
>     Rene> a chance that create_workqueue() could increase a reference
>     Rene> somewhere so that the module wouldn't be allowed to unload
>     Rene> untill after a destroy_workqueue()?
> 
> There's no point to doing this, since it's adding complexity to try
> and avoid a very obvious and easy to find bug.  Other types of
> resource leaks are harder to find, but a module not destroying a
> workqueue is going to be trivial to spot and fix.

Yes, fair enough. Thank you.

Rene.

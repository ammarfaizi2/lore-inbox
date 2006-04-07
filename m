Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWDGTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWDGTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGTM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:12:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbWDGTM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:12:57 -0400
Date: Fri, 7 Apr 2006 12:11:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: wierd failures from -mm1
Message-Id: <20060407121122.61d7f979.akpm@osdl.org>
In-Reply-To: <4436AD7D.5070307@mbligh.org>
References: <4436AA05.7020203@mbligh.org>
	<1144433309.24221.7.camel@localhost.localdomain>
	<4436AD7D.5070307@mbligh.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@mbligh.org> wrote:
>
> Dave Hansen wrote:
>  > On Fri, 2006-04-07 at 11:05 -0700, Martin Bligh wrote:
>  > 
>  >>http://test.kernel.org/abat/27596/debug/console.log
>  >>Hangs after bringing up cpus. 
>  > 
>  > 
>  > See attached patch.  It fixes curly.
> 
>  Splendid -thanks. This may well fix the first two ... I think the reiser
>  thing is likely still borked though.

The reiserfsck problem looks like a failed mlockall.  Reverting
mm-posix-memory-lock.patch should fix it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUGXCq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUGXCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUGXCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 22:46:59 -0400
Received: from peabody.ximian.com ([130.57.169.10]:64149 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268248AbUGXCq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 22:46:58 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Dan Aloni <da-x@gmx.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040723213223.GA637@callisto.yi.org>
References: <1090604517.13415.0.camel@lucy>
	 <20040723213223.GA637@callisto.yi.org>
Content-Type: text/plain
Date: Fri, 23 Jul 2004 22:47:06 -0400
Message-Id: <1090637226.1830.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 00:32 +0300, Dan Aloni wrote:

> IMHO you either should not assume anything about the length of the object 
> string, _or_ do the complete safe string assembly e.g:
> 
>         len += snprintf(buffer, PAGE_SIZE, "From: %s\nSignal: %s\n", 
>                         object, signal);
> 

Fair enough.  I guess what we want, exactly, is:

 len = snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
 len += snprintf(&buffer[len], PAGE_SIZE - len "Signal: %s\n", signal);

I will add that to the next revision.

	Robert Love



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWIRWm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIRWm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWIRWm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:42:57 -0400
Received: from smtp-out.google.com ([216.239.33.17]:40634 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751219AbWIRWm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:42:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=wVV49vshKQyoLp7iON2YApm15UJnROaOiSNz24ozyN8CLW2MBIn5V9dIC58DlYYk4
	8O2gbmeg88DA9K7XM7HfA==
Subject: Re: [ckrm-tech] [patch 0/5]-Containers: Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <1158613722.18300.3.camel@dyn9047017100.beaverton.ibm.com>
References: <1158284264.5408.144.camel@galaxy.corp.google.com>
	 <1158613722.18300.3.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 18 Sep 2006 15:42:05 -0700
Message-Id: <1158619326.18533.44.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 14:08 -0700, Badari Pulavarty wrote:
> On Thu, 2006-09-14 at 18:37 -0700, Rohit Seth wrote:
> > Containers:
> > 
> 
> I was just trying out your patches and ran into
> following Oops.
> 
> (Created a container, assigned a pid (shell) to it,
> set page limit and started a kernel compile in the shell).
> 

I wasn't initializing the ctn_task_list (in container_init_task_ptr) in
task structure.  Fixed.  Thanks for giving it a spin.  Will be releasing
a new version today.

(There is another change that would prevent non-configured container
kernels to not compile because of this patch.  Fixed that as well).

-rohit


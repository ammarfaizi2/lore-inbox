Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTECSyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTECSyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:54:51 -0400
Received: from rth.ninka.net ([216.101.162.244]:57065 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263380AbTECSyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:54:50 -0400
Subject: Re: [RFC][PATCH] Faster generic_fls
From: "David S. Miller" <davem@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Peter Osterlund <petero2@telia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200305020605_MC3-1-370C-A9C1@compuserve.com>
References: <200305020605_MC3-1-370C-A9C1@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051916132.13756.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 May 2003 15:55:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 03:04, Chuck Ebbert wrote:
>   I realized after sending that last that I should have added that there
> were no volatiles and no aliasing possible.  This was the kernel code:
> 
>   return conf->last_used = new_disk;
> 
> (new_disk is a local variable, conf is a function arg.)

Since new_disk is on the stack, is there something about 'conf'
that guarenetes it is not on the stack too?  F.e. what if
&conf->last_used were one byte into 'new_disk' or something
like that.

Probably this is all illegal...

-- 
David S. Miller <davem@redhat.com>

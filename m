Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGBO2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGBO2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGBO2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:28:51 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:40586 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264609AbUGBO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:28:50 -0400
In-Reply-To: <200407011751.25738.dtor_core@ameritech.net>
References: <200407011454.55440.dtor_core@ameritech.net> <1088720772.22742.21.camel@localhost> <200407011751.25738.dtor_core@ameritech.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22B73F26-CC34-11D8-BDBD-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PPC64: vio_find_node removal?
Date: Fri, 2 Jul 2004 09:28:50 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 1, 2004, at 5:51 PM, Dmitry Torokhov wrote:
>
> Ok, so if we add call to kobject_get in kset_find_obj we can just add
> kobject_put right in vio_find_name because there can be only one-to-one
> match between a slot and a vio device and we don't need refcounting 
> there,
> right?

Hmm. Yes, I agree that we need kobject_get and _put between 
kset_find_obj() and vio_find_name().

As for the lack of vio_dev refcounting... I think we can get away with 
it because rpaphp_vio.c is the only user who might unregister a 
vio_dev.

-- 
Hollis Blanchard
IBM Linux Technology Center


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSJQD2d>; Wed, 16 Oct 2002 23:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJQD2d>; Wed, 16 Oct 2002 23:28:33 -0400
Received: from dsl-213-023-039-240.arcor-ip.net ([213.23.39.240]:25766 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261754AbSJQD2c>;
	Wed, 16 Oct 2002 23:28:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] change format of LSM hooks
Date: Thu, 17 Oct 2002 05:33:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davem@redhat.com, becker@scyld.com, jmorris@intercode.com.au,
       kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20021015194545.GC15864@kroah.com> <20021016000706.GI16966@kroah.com> <20021017114127.759e0e81.rusty@rustcorp.com.au>
In-Reply-To: <20021017114127.759e0e81.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1821PX-0004Ob-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 03:41, Rusty Russell wrote:
> This also allows someone in the future to do:
> 
> 	#define security_call(func, default_ret, ...) \
> 		({ if (try_inc_mod_count(security_ops->owner))
> 			(security_ops->func(__VA_ARGS__));
> 		   else
> 			(default_ret);
> 		})

Hopefully, dec_mod_count as well.

-- 
Daniel

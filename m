Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSHHDXD>; Wed, 7 Aug 2002 23:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSHHDWz>; Wed, 7 Aug 2002 23:22:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16363 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S317334AbSHHDWx>;
	Wed, 7 Aug 2002 23:22:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: softirq parameters 
In-reply-to: Your message of "Wed, 07 Aug 2002 11:24:24 MST."
             <20020807.112424.60322440.davem@redhat.com> 
Date: Thu, 08 Aug 2002 12:29:30 +1000
Message-Id: <20020808032826.AAE5F4A86@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020807.112424.60322440.davem@redhat.com> you write:
>    From: Matthew Wilcox <willy@debian.org>
>    Date: Wed, 7 Aug 2002 19:35:04 +0100
>    
>    Hrm, I didn't realise what the implementation of percpu was... does it
>    work for modules?
>    
> Good question, I bet it doesn't based upon how I understand
> it to work.

Yes, it doesn't work for modules.  The IBM guys have a kmalloc_percpu
thing which will, but I'm not trying to change the world.

This is one reason for changing to DECLARE_PER_CPU and DEFINE_PER_CPU
macros (the other is because RTH wants to use __thread for per-cpu
variables).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

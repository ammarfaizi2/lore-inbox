Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVINKJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVINKJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVINKJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:09:13 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:51603 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932537AbVINKJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:09:12 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17191.62553.449139.119606@gargle.gargle.HOWL>
Date: Wed, 14 Sep 2005 13:58:49 +0400
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com, lion.vollnhals@web.de
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Newsgroups: gmane.linux.kernel
In-Reply-To: <200509140802.59435.vda@ilport.com.ua>
References: <200509130010.38483.lion.vollnhals@web.de>
	<Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI>
	<17190.33539.992902.463545@gargle.gargle.HOWL>
	<200509140802.59435.vda@ilport.com.ua>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:

[...]

 > 
 > I remember that sizeof has two forms: sizeof(type) and
 > sizeof(expr), and in one of them ()'s are optional.
 > But I fail to remember in which one. I use ()'s always.

Formally speaking, sizeof have forms

        sizeof(type), and

        sizeof expr

it is just that expression can usually be wrapped into parentheses, like
(((((0))))).

 > 
 > Thanks for refreshing my memory but I'm sure
 > I'll forget again ;)

That's why we need more instances of sizeof expr in the kernel code, to
keep your knowledge of C afresh all the time. :-)

Note that Linux doesn't follow a custom of... some other kernels to
parenthesize everything to the heretical extent of writing 

   if ((a == 0) && (b == 1))

or

   return (foo);

 > --
 > vda

Nikita.

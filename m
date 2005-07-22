Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVGVNLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVGVNLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGVNLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:11:06 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:28051 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262081AbVGVNLD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:11:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PTZovOwIE8ghSnPnFZl57KdLV+KT73wNv83vNNKlfUDD8ImWNggZfF592nAaoRDRzfWe7T6rdt7EkbeLhcUtLp/lyhNY/k+4l3T0yiAGqj1O/eybT+NgFcd5JH6Kmk/t5q3ps+x/7x06a+SEiQwW/15wYpJrg72wUTbV37PtHL8=
Date: Fri, 22 Jul 2005 13:31:40 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Ashley" <ashleyz@alchip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-Id: <20050722133140.22f64a17.diegocg@gmail.com>
In-Reply-To: <003401c58ea2$4dfd76f0$5601010a@ashley>
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 22 Jul 2005 17:46:58 +0800,
"Ashley" <ashleyz@alchip.com> escribió:

> from the output of command "free", I can see that many GB memory was cached 
> by kernel. Does anyone know how to free the kernel cached
> memory? thanks in advance.


You don't want that. Kernel will free cached memory when apps need it. When
there's a lot of free memory, linux always tries to use it for cache - because
caches speed up things, and it's silly to to leave memory free if you can
use it for caching.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVKPKSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVKPKSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVKPKSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:18:31 -0500
Received: from smtp.terra.es ([213.4.129.129]:34543 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S932596AbVKPKSa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:18:30 -0500
Date: Wed, 16 Nov 2005 11:18:12 +0100
From: "Wed, 16 Nov 2005 11:18:12 +0100" <grundig@teleline.es>
To: Arjan van de Ven <arjan@infradead.org>
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051116111812.4a1ea18a.grundig@teleline.es>
In-Reply-To: <1132128212.2834.17.camel@laptopd505.fenrus.org>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
	<1132128212.2834.17.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 16 Nov 2005 09:03:32 +0100,
Arjan van de Ven <arjan@infradead.org> escribió:


> * more stack space is available for interrupts compared to 2.4 kernels
>    - in 2.4 kernels only 2Kb was available for interrupt context (to
>      keep 4K available for user context). With complex softirqs such as
>      PPP and firewall rules and nested interrupts this wasn't always
>      enough. Compared to 2.6-with-8Kstacks is a bit harder; there is
>      2Kb extra available there compared to 2.4 and arguably some of that
>      extra is for interrupts.


I would like to contribute that listing with two non-technical reasons
more:

 * Encourages good code. Due to the 4 Kb stacks patch several parts of
	the kernel have gone on diet, improving the quality of the code
	(see ndiswrapper, ndis drivers can overflow the stack even with
	8KB stacks, the 4KB patch will force them to develop a _real_
	safe solution for that, improving the quality of ndiswrapper).

 * Some distros are enabling 4KB (fedora), other distros aren't, so
	having a single stack size option will make 3rd party modules
	distribution easier (some propietary drivers may not be caring
	about making their drivers work with 4Kb stacks due to the lack
	of uniformity)

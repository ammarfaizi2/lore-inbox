Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWEJO3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWEJO3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWEJO3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:29:15 -0400
Received: from www.osadl.org ([213.239.205.134]:15336 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751448AbWEJO3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:29:14 -0400
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1147266235.3969.31.camel@frecb000686>
References: <20060510112651.24a36e7b@frecb000686>
	 <20060510100858.GA31504@elte.hu>  <1147266235.3969.31.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Wed, 10 May 2006 16:32:14 +0200
Message-Id: <1147271536.27820.288.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 15:03 +0200, Sébastien Dugué wrote:
>   Maybe the pthread_cond_*() function should be made to use the
> PI-futexes support in glibc.

<hack_alert>

There is a simple way to do so. Just remove the assembler version of
pthread_cond_xx and use the generic c code implementation in glibc. That
allows you to use a PI mutex for the outer mutex.

</hack_alert>

	tglx



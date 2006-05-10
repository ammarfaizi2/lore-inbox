Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWEJObc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWEJObc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWEJObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:31:31 -0400
Received: from [63.81.120.158] ([63.81.120.158]:18803 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751452AbWEJObb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:31:31 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147257266.17886.3.camel@localhost.localdomain>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 07:31:29 -0700
Message-Id: <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 11:34 +0100, Alan Cox wrote:
> 
> This causes very poor code as its initializing an object on the stack.
> It also appears from inspection to be entirely un-neccessary. Instead
> the compiler needs some help.

It's just a warning .. The compiler flagged a spot which look suspect .
We have -Wall turn on now , so we could possibly disable these
warnings. 

> Hiding warnings like this can be a hazard as it will hide real warnings
> later on.

How could it hide real warnings? If anything these patch allow other
(real warnings) to be seen . 


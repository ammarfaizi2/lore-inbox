Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290662AbSARKoJ>; Fri, 18 Jan 2002 05:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290665AbSARKn7>; Fri, 18 Jan 2002 05:43:59 -0500
Received: from smtp04.wxs.nl ([195.121.6.59]:12025 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S290662AbSARKnr>;
	Fri, 18 Jan 2002 05:43:47 -0500
Subject: Re: [PATCH] Combined APM patch
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020111154016.D31366@flint.arm.linux.org.uk>
In-Reply-To: <1010762545.788.2.camel@thanatos> 
	<20020111154016.D31366@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Jan 2002 05:43:48 -0500
Message-Id: <1011350629.1275.15.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 10:40, Russell King wrote:
> On Fri, Jan 11, 2002 at 10:22:24AM -0500, Thomas Hood wrote:
> > if someone later wants to modify the code to make
> > this variable non-static, the comment tells that person that
> > the variable will need an initializer.
> 
> Whether a variable is static or not doesn't change whether it ends up in
> the bss segment or not.

It does make a difference if the variable definitions are inside
a function; the non-static variable is on the stack and is not
initialized to zero.

I understand that every static or top-level global variable
is initialized to zero; but is it not useful to note when
the code _relies upon_ this zero-initialization?  



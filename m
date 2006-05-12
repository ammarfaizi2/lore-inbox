Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWELSov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWELSov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWELSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:44:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48097 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751317AbWELSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:44:51 -0400
Subject: Re: mlock into kernel module
From: Arjan van de Ven <arjan@infradead.org>
To: "sej.kernel" <sej.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4464A819.2050706@gmail.com>
References: <4464A819.2050706@gmail.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 20:44:48 +0200
Message-Id: <1147459488.3173.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 17:22 +0200, sej.kernel wrote:
> Hello,
> I need to use mlock and munlock function into a kernel module. How so
> I call this system call from my module ?

no it's a bug if you need to do that

> I need to do this because I must use mlock in my software, but I can't
> use root or suser to start it. So mlock alwaays fail.

that's an rlimit thing, just fix the rlimit on your system.

Also if you want to do this for pinning hardware at a physical address
you have a really wrong design (mlock is the wrong api) which also
includes a security hole btw
 


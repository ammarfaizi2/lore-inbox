Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWEJONw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWEJONw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWEJONw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:13:52 -0400
Received: from [63.81.120.158] ([63.81.120.158]:39529 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751416AbWEJONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:13:50 -0400
Subject: Re: [PATCH -mm] megaraid gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <1147257558.17886.8.camel@localhost.localdomain>
References: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
	 <1147257558.17886.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 10 May 2006 07:13:46 -0700
Message-Id: <1147270427.21536.64.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 11:39 +0100, Alan Cox wrote:
> On Maw, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> > Fixes the following warning,
> > 
> > drivers/scsi/megaraid.c: In function ‘issue_scb’:
> > drivers/scsi/megaraid.c:1153: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
> 
> And adds an exploitable memory leak. Please don't fix "bugs" blindly but
> check that the error path still releases all the relevant resources.

I did nothing blindly .. I have a queue of 50+ more of these. I
researched every error path , and made sure the warning wasn't an actual
problem. If it was a problem , or I wasn't sure if the fix was 100% I
sent it to LKML ..

Daniel




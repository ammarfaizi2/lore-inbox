Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbSI1AqK>; Fri, 27 Sep 2002 20:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262661AbSI1AqK>; Fri, 27 Sep 2002 20:46:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:262
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262660AbSI1AqK>; Fri, 27 Sep 2002 20:46:10 -0400
Subject: Re: Sleeping function called from illegal context...
From: Robert Love <rml@tech9.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020927233044.GA14234@kroah.com>
References: <20020927233044.GA14234@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1033174290.23958.17.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 27 Sep 2002 20:51:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 19:30, Greg KH wrote:

> The system still seems to be running ok, but I think I'll turn off
> CONFIG_PREEMPT just to be sure.

Note this has nothing to do with kernel preemption.  IDE explicitly
sleeps while purposely holding a lock.

It is just we do not have the ability to measure atomicity w/o
preemption enabled - e.g. the debugging only works when it is enabled.

	Robert Love


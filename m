Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTE0Pth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTE0Pth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:49:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263936AbTE0Ptg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:49:36 -0400
Date: Tue, 27 May 2003 17:02:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Corey Minyard <minyard@acm.org>
Cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3 - ipmi unresolved)
Message-ID: <20030527160247.GA27916@parcelfarce.linux.theplanet.co.uk>
References: <20707.1054013443@kao2.melbourne.sgi.com> <3ED37AD5.7020607@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED37AD5.7020607@acm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 09:48:53AM -0500, Corey Minyard wrote:

> >The user does have to do something.  Every piece of code that calls
> >notify_register has to set the new field to __THIS_MODULE.  WIthout
> >that field being set, you are no better off, the race still exists.
> >
> Why?  The user doesn't have to set the field, you can let the
> registration code do that.  I have attached a patch as an example.

How the devil would registration code figure out which module should
be used?

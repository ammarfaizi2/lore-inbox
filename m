Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbULNVC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbULNVC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbULNVC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:02:56 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:16520 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbULNVCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:02:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kn5xEsbvm5TRnvDvyJD5DdddCqccXgm+gk0JkhfLpTVDIHrwzY5V79KjdvIfSeTi5Yqilv4eWjhJMY7+uyZasUz9PwAQ/anFw1DM7PnbWYoUEPTAEahc0n9ByHjZPUnrBxEWJz0sGm8kU3iD4q/jmsa320Pk0XSOokp9YKMw2v4=
Message-ID: <5afb2c65041214125270170a1@mail.gmail.com>
Date: Tue, 14 Dec 2004 18:52:21 -0200
From: Fabiano Ramos <fabiano.ramos@gmail.com>
Reply-To: ramos_fabiano@yahoo.com.br
To: Chris Wright <chrisw@osdl.org>
Subject: Re: help with access_process_vm
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041214123124.R469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5afb2c65041214112577ff4a18@mail.gmail.com>
	 <20041214123124.R469@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The access_process_vm() call is doing down_read(), which could sleep,
> with irqs disabled.  That's what's wrong.
> 



Is it possible to put the process that caused the trap to sleep, call
schedule and
defer this access_process_vm to later on with irqs enabled and only than resume
the faulty process?

I want to write the the faulty process image.

Thanks
Fabiano

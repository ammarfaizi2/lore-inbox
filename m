Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270315AbUJEQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270315AbUJEQIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270298AbUJEQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:08:46 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:52915 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270445AbUJEQHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:07:46 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200410051801.03677.oliver@neukum.org>
References: <1096401785.13936.5.camel@localhost.localdomain>
	<200410051749.22245.oliver@neukum.org> <1096991666.2064.25.camel@mulgrave> 
	<200410051801.03677.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Oct 2004 11:07:31 -0500
Message-Id: <1096992458.2173.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 11:01, Oliver Neukum wrote:
> Why is it in any way difficult to decide whether to issue a command in the
> first place? The command is generated upon being notified by the lower layer.
> There is no issue of synchronisation here. It is simply stupid to give
> commands that are bound to fail, if the information is already available.

a) we don't know that they are ... for notified ejection they will
succeed.

b) The scsi bus is a scanned model ... drivers must be prepared to
accept commands for non-existent devices. How does the removal case
differ from the never present case?

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263926AbUDVLJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbUDVLJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbUDVLJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:09:48 -0400
Received: from mtagate7.de.ibm.com ([195.212.29.156]:49891 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S263926AbUDVLJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:09:47 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Arjan van de Ven <arjanv@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF2D677553.6D72A833-ONC1256E7E.003D0651-C1256E7E.003D4886@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 13:09:22 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 13:09:23
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> why? Most hardware have an alternative time source for such time stamps.
> Timer events *won't* be delivered too late, simply *because* the timer
said
> "don't bother checking back for X amount of time", so when that time has
> expired (eg the delay) then the timer comparison tells the kernel "ok
this
> one is due now".

Huh? You lost me there. The HZ timer is the interrupt that will trigger the
execution of a timer event. If you say "don't bother checking back for X
amount of time" the cpu stays in idle doing nothing. You won't get control
to execute the timer event.

blue skies,
   Martin


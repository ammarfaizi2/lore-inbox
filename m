Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269318AbUJFRoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbUJFRoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJFRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:43:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269337AbUJFRnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:43:49 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097080873.29204.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 17:41:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 15:52, Joris van Rantwijk wrote:
> My understanding of POSIX is limited, but it seems to me that a read call
> must never block after select just said that it's ok to read from the
> descriptor. So any such behaviour would be a kernel bug.

Select indicates there may be data. That is all - it might also be an
error, it might turn out to be wrong.

You should always combine select with nonblocking I/O


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbSJBKaM>; Wed, 2 Oct 2002 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbSJBKaM>; Wed, 2 Oct 2002 06:30:12 -0400
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:44454 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S263098AbSJBKaL>; Wed, 2 Oct 2002 06:30:11 -0400
Date: Wed, 2 Oct 2002 12:35:21 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: linux-kernel@vger.kernel.org
Subject: POSIX message queues
Message-ID: <Pine.GSO.4.40.0210021234230.16975-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello

After getting some response from lkml we are ready for
work on new version of POSIX message queues.

Main difference (as Christoph Hellwig suggested) would be
implementing it as a virtual filesystem (based on tmpfs and
parts of Jakub Jelinek code).
I think that we can agree that idea of moving whole stuff to
user space isn't good. There is still a problem with SIGEV_THREAD
version of notification but after (brief) looking into NPTL it
should be possible to implement (in difference to NGPT)


So our question is:
Is above version acceptable for Linux kernel?

Main advantages of such approach are: no need for new
system call and no mess in fork/exit.


 Krzysztof Benedyczak


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264175AbRFFVh2>; Wed, 6 Jun 2001 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264174AbRFFVhS>; Wed, 6 Jun 2001 17:37:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264173AbRFFVhI>; Wed, 6 Jun 2001 17:37:08 -0400
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed in the
To: thierry.lelegard@canal-plus.fr
Date: Wed, 6 Jun 2001 22:35:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1E3D86.C7A7874@canal-plus.fr> from "thierry.lelegard@canal-plus.fr" at Jun 06, 2001 04:26:14 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157kxf-0000UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This report describes a problem in the usage of file descriptors across
> multiple threads. When one thread closes a file descriptor, another
> thread which waits for an I/O on that file descriptor is not notified
> and blocks forever.

THe I/O does not block forever, it blocks until completed. The actual final
closure of the object occurs when the last operation on it exits


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269477AbRHCRAm>; Fri, 3 Aug 2001 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRHCRAc>; Fri, 3 Aug 2001 13:00:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269477AbRHCRAT>; Fri, 3 Aug 2001 13:00:19 -0400
Subject: Re: DoS with tmpfs #3
To: iive@yahoo.com (Ivan Kalvatchev)
Date: Fri, 3 Aug 2001 18:02:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Ivan Kalvatchev" at Aug 03, 2001 09:34:09 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SiKw-0003aC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The same horrible think happens to ramfs, but this
> could be expected. Ramfs don't have size check so that
> hack cannot be used for it.  In this case ramfs must
> be marked as dangerous. 

Ramfs and tmpfs in the -ac tree should behave a lot better. The 
fact you see high pages being a factor sounds to me like a VM rather than
a tmpfs bug. Specifically you should have seen KDE apps terminating with
out of memory kills. 

In paticular in the -ac tree ramfs supports setting limits on the max fs
size, which is essential if you want to use it on something like an iPAQ
where ramfs is a real useful fs to have.

tmpfs would I suspect also benefit immensely from quota support

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285185AbRLXSOM>; Mon, 24 Dec 2001 13:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285195AbRLXSOC>; Mon, 24 Dec 2001 13:14:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285185AbRLXSNx>; Mon, 24 Dec 2001 13:13:53 -0500
Subject: Re: [patch] Assigning syscall numbers for testing
To: dledford@redhat.com (Doug Ledford)
Date: Mon, 24 Dec 2001 18:23:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
In-Reply-To: <3C27608B.4030900@redhat.com> from "Doug Ledford" at Dec 24, 2001 12:06:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IZl0-0004mP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> syscall bindings.  My example was about code using the predefined syscall 
> number for new functions on an older kernel where those functions don't 
> exist, but where they overlap with the older dynamic syscall numbers.  In 
> short, the patch is safe for code that uses the lazy binding, but it can 
> still overlap with future syscall numbers and code that doesn't use the lazy 
> binding but instead uses predefined numbers.

Now I follow you. So if Linus takes that patch he needs to allocate a block
of per architecture dynamic syscall number space for it to use. Negative
syscall numbers seem the most promising approach ?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269680AbUJMLl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269680AbUJMLl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 07:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUJMLl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 07:41:29 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60103 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269680AbUJMLl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 07:41:27 -0400
Subject: Re: Write USB Device Driver entry not called
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: eshwar <eshwar@moschip.com>
Cc: Raj <inguva@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
	 <b2fa632f0410122315753f8886@mail.gmail.com>
	 <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097663878.4440.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 11:37:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 18:52, eshwar wrote:
> Open is sucessfull.... I don't think the problem the flags of open

I do. See any book on C/Unix style file opening. For an existing file
you want
		open("foo", O_flags)

for a new file possibly

		open("foo", O_CREAT|o_flags, S_Iblah)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVAJMNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVAJMNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVAJMNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:13:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42185 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262217AbVAJMNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:13:41 -0500
Subject: Re: Flaw in ide_unregister()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <067d01c4f69b$cb9d8b80$0f01a8c0@max>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max>
	 <1104674725.14712.50.camel@localhost.localdomain>
	 <067d01c4f69b$cb9d8b80$0f01a8c0@max>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105314226.12054.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 11:09:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-09 at 22:37, Richard Purdie wrote:
> I haven't investigated it yet but I suspect the usage count is held by 
> ide-disk as the CF card has a mounted filesystem. As previously mentioned 
> and for reference, this patch has the changes I had to make to get standard 
> 2.6.10 to work:

Correct. This is intentional - what the -ac code allows you to do
(although you probably need to move the final free up to a workqueue) is
to free the hardware resources. The ide resources will then free later
on the umount


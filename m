Return-Path: <linux-kernel-owner+w=401wt.eu-S932463AbWLLWE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWLLWE2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWLLWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:04:28 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:60925 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbWLLWE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:04:27 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: O2micro smartcard reader driver.
Date: Tue, 12 Dec 2006 23:05:53 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be> <200611281249.45243.oliver@neukum.org> <457F1F0F.20109@tremplin-utc.net>
In-Reply-To: <457F1F0F.20109@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612122305.53767.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Dezember 2006 22:28 schrieb Eric Piel:

Hi

> Thanks a lot for reading my code, I didn't even hope that someone would! 
> I've corrected the copy_to_user (and copy_from_user) code. However I 
> don't know how to do locking for the concurrent ioctls. Indeed, I don't 
> think there is anything preventing two programs to call the driver at 
> the same time. Unfortunately, I've got no idea how to do the locking and 
> surprisingly couldn't find any ioctl code in the kernel doing locking. 
> Maybe I've just not looked at the right place, could you give a me some 
> hint how to do locking for ioctl's ?

I take it back. Reading your code again, it seems to me that it'll
never sleep. In this case you are protected by BKL. If not, you need
to use mutexes, just like eg. in drivers/usb/class/usblp.c

	HTH
		Oliver

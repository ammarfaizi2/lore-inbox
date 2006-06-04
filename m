Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932213AbWFDKTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWFDKTD (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFDKTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:19:03 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:12869 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932213AbWFDKTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:19:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nE5rYMXa4bnpJzjRXVGNfAULAn6CsTcu2fXEYQPZlkiEw3qS4tAPEy4cGXFcS9xWpjuCiNhmZEgEeLiJabx2vXSVs8t2aWQo/iR1V9Z1aKoRTpDsDw0j/j8UI1dVJF4LNGwFe6uWVKcfgN9/Jj+4JSFBxWg74S/9NeFFrHsioFY=
Message-ID: <beee72200606040319g2e933d52j598b68cec2565be0@mail.gmail.com>
Date: Sun, 4 Jun 2006 12:19:01 +0200
From: "davor emard" <davoremard@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SMP HT + USB2.0 crash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

I have an asus MB with intel 925XE chipset and hyperthreading capable CPU.
Certain lockups with random oops occur all through kernel 2.6.16.19. Some of
lockups are SMP only oopses (sorry but I didn't catch them exactly to a file),
other are usually like this attached file

As a general rule, if both
1) SMP
2) EHCI (usb 2.0)

Are enabled and USB2.0 devices are used frequently, then
kernel lockup appear between few minutes and 1 day. It is very annoying

Disabling either SMP or the EHCI fixes the lockups. Probably some
missing spin_lock or whatever in EHCI...

Emard

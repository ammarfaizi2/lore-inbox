Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUEQGfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUEQGfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 02:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUEQGfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 02:35:44 -0400
Received: from host79.200-117-132.telecom.net.ar ([200.117.132.79]:2535 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S264915AbUEQGfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 02:35:43 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Date: Mon, 17 May 2004 03:35:42 -0300
User-Agent: KMail/1.6.2
References: <200405131411.52336.amann@physik.tu-berlin.de>
In-Reply-To: <200405131411.52336.amann@physik.tu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405170335.42754.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Amann wrote:
> kmail: Error: Could not add message to folder (No space left on device?)
> kmail: WARNING: KMail encountered a fatal error and will terminate now.
> The error was:
> KMFolderMaildir::addMsg: abnormally terminating to prevent data loss.
> ...

Well, I'm getting this with kcalc after upgrading to 2.6.6-mm3:

$ kcalc
KCrash: Application 'kcalc' crashing...

strace shows lots of 
...
close(1002)                             = -1 EBADF (Bad file descriptor)
close(1003)                             = -1 EBADF (Bad file descriptor)
close(1004)                             = -1 EBADF (Bad file descriptor)
close(1005)                             = -1 EBADF (Bad file descriptor)
...

Now it's late. More tests and info tomorrow (unless there's a new -mm kernel 
which fixes this :-) )

Regards,
Norberto

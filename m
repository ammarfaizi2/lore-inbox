Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWJQSgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWJQSgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWJQSgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:36:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:34787 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751417AbWJQSgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:36:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding;
  b=rnA2xOoqh78fWRyBbR/zyyg562z7jQ/+JOWiFkM/jSUCXTqFikiXe7y+MIlRn+S15enhkRZnGAIXnmqj/z/KK2Vc1zr7qU7+yFM+Ut/pVNHNsboHMRo6M/g7Qb+zryyTZ5x6iSaX0dL9rSHxAN2FZwcO9Iz5ASGz0ZoRszbL2PY=  ;
Message-ID: <45352148.4020706@sbcglobal.net>
Date: Tue, 17 Oct 2006 14:30:32 -0400
From: "Robert W. Fuller" <garbageout@sbcglobal.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060814)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: nfs file locking broken
References: <453145DD.3040501@sbcglobal.net>
In-Reply-To: <453145DD.3040501@sbcglobal.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert W. Fuller wrote:
> I tried to upgrade from 2.6.16.27 to 2.6.17.13.  I have also tried
> 2.6.18.1.  I discovered NFS file locking no longer works between a Linux
> client and an OpenBSD server.  For example, gtk-gnutella gets the
> following error:
> 
> 06-10-14 15:50:19 (WARNING): fcntl(8, F_SETLK, ...) failed for
> "/home/edison/.gtk-gnutella/gtk-gnutella.pid": Permission denied
> 
> gpg hangs waiting for a lock for ~/.gnupg/random_seed

Maybe the thing to do is to Cc: the NFS guy on this?  Anybody else have
any suggestions?

Is there a known fundamental change in the Linux NFS client that would
break file locking between a Linux NFS client and an OpenBSD-3.8 NFS
server?    Is OpenBSD-3.8 somehow broken with respect to new behavior in
the Linux NFS client?

This is very reproducible.  File locking works with 2.6.16.27.  Sometime
thereafter it ceased to work.  There are no configuration changes to
/etc or anything like that....  For me, it's a simple matter of choosing
a working kernel from the GRUB menu or a broken kernel.


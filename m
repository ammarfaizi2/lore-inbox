Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCNP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCNP2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCNP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:28:00 -0500
Received: from newmail.linux4media.de ([193.201.54.81]:42648 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S261539AbVCNP16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:27:58 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: Evgeniy <shubin_evgeniy@mail.ru>
Subject: Re: bug in kernel
Date: Mon, 14 Mar 2005 16:22:57 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200503141748.05661.shubin_evgeniy@mail.ru>
In-Reply-To: <200503141748.05661.shubin_evgeniy@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503141622.57572.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2005 15:48, Evgeniy wrote:
> #include <stdio.h>
> #include <errno.h>
> main(){
>   int err;
>   err=read(0,NULL,6);
>   printf("%d %d\n",err,errno);
> }

On my box (2.6.11), that does exactly what it is supposed to do -- "-1 14"
14 == EFAULT == "Bad Address", which is what NULL is...

Btw, printf("%d %d %s\n", err, errno, strerror(errno)); gives you a more 
readable error, that would immediately show you did get the right error.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVDJWcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVDJWcp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDJWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:32:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:58298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbVDJWcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:32:42 -0400
Date: Sun, 10 Apr 2005 15:32:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-Id: <20050410153228.1452365a.akpm@osdl.org>
In-Reply-To: <42592813.5020005@aknet.ru>
References: <20050405065544.GA21360@elte.hu>
	<4252E2C9.9040809@aknet.ru>
	<Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>
	<4252EA01.7000805@aknet.ru>
	<Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
	<425403F6.409@aknet.ru>
	<20050407080004.GA27252@elte.hu>
	<42555BBF.6090704@aknet.ru>
	<Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org>
	<425563D6.30108@aknet.ru>
	<Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
	<42592813.5020005@aknet.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> -	p->thread.esp0 = (unsigned long) (childregs+1);
>  +	p->thread.esp0 = (unsigned long) (childregs+1) - 8;

This is utterly obscure - it needs a comment so that readers know what that
"- 8" is doing there.


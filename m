Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVDGQqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVDGQqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVDGQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:46:14 -0400
Received: from mail.aknet.ru ([217.67.122.194]:31758 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262520AbVDGQqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:46:08 -0400
Message-ID: <425563D6.30108@aknet.ru>
Date: Thu, 07 Apr 2005 20:46:14 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu> <42555BBF.6090704@aknet.ru> <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Linus Torvalds wrote:
> So I really think that the _correct_ fix is literally to move the "cli" 
> in the sysenter path down two lines. It doesn't just "hide" the bug, it 
> literally fixes is.
OK, Linus, I find it amazing that you
like all my patches, even though I myself
think they are wrong:)
I still have those two questions however:
1. Does the "later sti" fixes the problem
also in case of an NMI? I mean, why can't
you just be NMI'ed before you did sti?
NMI uses the restore_all too IIRC.
2. How can one be sure there are no more
of the like places where the stack is left
empty?


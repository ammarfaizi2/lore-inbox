Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQKGOmu>; Tue, 7 Nov 2000 09:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129673AbQKGOmk>; Tue, 7 Nov 2000 09:42:40 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:30965 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129666AbQKGOmb>;
	Tue, 7 Nov 2000 09:42:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A070BEF.7712DEDB@didntduck.org> 
In-Reply-To: <3A070BEF.7712DEDB@didntduck.org>  <200011061924.QAA31314@srv1-for.for.zaz.com.br> 
To: Brian Gerst <bgerst@didntduck.org>
Cc: forop066@zaz.com.br, linux-kernel@vger.kernel.org
Subject: Re: Calling module symbols from inside the kernel ! 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 14:41:42 +0000
Message-ID: <13979.973608102@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bgerst@didntduck.org said:
>  You will need to use a function pointer hook that the module fills in
> when it is loaded.  For an example look at devpts_upcall_new and
> devpts_upcall_kill in fs/devpts/inode.c.  The hooks are resident in
> the kernel and are exported so the module can see them.  The caller
> then needs to check if the hook is null and optionally request the
> module be loaded.

get_module_symbol() does this for you without having to use such a hook

/me runs


:)


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

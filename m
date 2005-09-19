Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVISOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVISOqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVISOqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:46:36 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:27305 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932447AbVISOqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:46:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m4466Q3RWYwoW7dzwgSLEbdS23C7Dv3DSG0Nf2fHjn4uwynAfl6cCsH+J94TR2Eu0QQHWrL+L0RBGujebwEw/JQIdZva4eUPaY9JyfMqYHMOTqngrJiaZnBnlHwe1yYb7WSKoSFF9/ZISl9YaA+iVuyWIjoMhYu51zZSGBOLcFI=
Message-ID: <f8fda533050919074628ff140e@mail.gmail.com>
Date: Mon, 19 Sep 2005 22:46:33 +0800
From: Wenfeng Liu <wenfeng.liu@gmail.com>
Reply-To: wenfeng.liu@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [Questions] About experience of using kgdb for 2.6.10 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, All

Recently I use kgdb for 2.6.10 kernel to debug driver modules. I got
the kgdb patch from kgdb CVS server. Here I have some experience of
using it with questions.

1. I use gdbmod-2.2 which is claimed to support automatically load
module symbol to correct address, but it don't do as that. I have to
manually add .text/.data/.bss sections address as add-symbol-file
parameters in gdb commands. Does anybody meet this?
2. I can't add one breakpiont for codes in symbol unless I stop in
sys_init_module and use "step" into module_init routine. It's not
convenient for module debugging, because every time I has to add
breakpoints in module_init, even I don't want to debug it. :(
3. The connection often hangs with printing "error packet" message
especially adding breakpoints or strike "n" quickly for multiple
times. And then the debug can't continue without restart.

Anyway, kgdb is a very good tool for kernel debugging. But from my
experience, it's not stable -- or my usage faults? Is anybody willing
to share with me his experience/knowledge?

Thanks much,
Kent

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSKMS35>; Wed, 13 Nov 2002 13:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSKMS35>; Wed, 13 Nov 2002 13:29:57 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:45213 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262303AbSKMS3z>;
	Wed, 13 Nov 2002 13:29:55 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: rusty@rustcorp.com.au
Date: Wed, 13 Nov 2002 19:36:23 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Modules in 2.5.47-bk...
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <76A6C122742@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
  I'm probably missing something important, but do you have any plans
to integrate module-init-tools into modutils, or extend module-init-tools
functionality to make them usable? I tried module-init-tools 0.6
and I must say that I'm really surprised that it is possible to make
such change after feature freeze, without maintaining at least minimal
usability.

  If there are modutils which can live with new module system, please
point me to them. But I did not found such.

  For now I gave up. Except other, I did not found way how to pass
options to module: MODULE_PARM() is now always nothing, and
while options are probably stored in THIS_MODULE->args, I see
no users of this (load_module finds .setup.init (which is now named
.init.setup, and __setup expands to it only ifndef MODULE, BTW!), but 
ignores it afterward).

  So in short, is there available some document which says why this
change was needed, where it is going, and what fs and device driver
developers (ie. me) should do to get their (ie. mine) drivers back 
to working state? Should I just concentrate on my other projects,
and stop tracking 2.5.x kernels? Or should I just do couple of
cset -x ?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTEMCtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEMCtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:49:21 -0400
Received: from [218.19.159.45] ([218.19.159.45]:260 "EHLO zhangtao.treble.net")
	by vger.kernel.org with ESMTP id S263140AbTEMCtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:49:20 -0400
Date: Tue, 13 May 2003 10:17:40 +0800
From: zhangtao <zhangtao@zhangtao.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>
Cc: LinuxKernel MailList <linux-kernel@vger.kernel.org>
Subject: About NLS Codepage 932
Message-Id: <20030513101740.626a06a5.zhangtao@zhangtao.org>
In-Reply-To: <1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
References: <20030512100534.1ba6ecd6.zhangtao@zhangtao.org>
	<1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Codepage 949 Translation table can download from:

  http://web.mit.edu/afs/dev.mit.edu/source/src-current/third/libiconv/tests/CP932.TXT

(CP932 is Japanese letters, Japanese Shift-JIS)

But it has much more different of tables in "http://www.microsoft.com/globaldev/reference/dbcs/932.htm"

the origin CP932 table of kernel nls_cp932.c, is close to the Microsoft's table in the web (still some different).

The big different is the area of Char To Unicode, the lead byte is :
  0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9

In the Microsoft's table (http://www.microsoft.com/globaldev/reference/dbcs/932.htm), they are EMPTY!
But in the Mit edu's CP932.TXT (http://web.mit.edu/afs/dev.mit.edu/source/src-current/third/libiconv/tests/CP932.TXT), they have corresponding letters. 

Which one is correct? Can someone tell me?  Thanks!


							zhangtao 
							zhangtao@zhantao.org

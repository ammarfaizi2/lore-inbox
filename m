Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129463AbQKGDMC>; Mon, 6 Nov 2000 22:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKGDLw>; Mon, 6 Nov 2000 22:11:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8202 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129463AbQKGDLg>;
	Mon, 6 Nov 2000 22:11:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: forop066@zaz.com.br
cc: linux-kernel@vger.kernel.org
Subject: Re: Calling module symbols from inside the kernel ! 
In-Reply-To: Your message of "Mon, 06 Nov 2000 16:24:13 -0300."
             <200011061924.QAA31314@srv1-for.for.zaz.com.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 14:11:04 +1100
Message-ID: <9668.973566664@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000 16:24:13 -0300, 
forop066@zaz.com.br wrote:
>Is it possible to access symbols exported by modules from inside the kernel ?

Not via symbol name, the linkage goes module => kernel, not the other
way round.  Your module needs to register its data when it loads, then
any code can use the registration "get" function to access the data.
This works kernel <=> kernel, kernel <=> module, module <=> module.  Be
careful that you lock the module down while you are using its data.

See ftp://ftp.ocs.com.au/pub/2.4.0-test10-pre6-module-symbol.gz for
sample registration code.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

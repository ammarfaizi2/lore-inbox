Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbTLFRnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265220AbTLFRnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:43:42 -0500
Received: from stinkfoot.org ([65.75.25.34]:37778 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265218AbTLFRnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:43:40 -0500
Message-ID: <3FD215F9.8070506@stinkfoot.org>
Date: Sat, 06 Dec 2003 12:46:33 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23: aic7xxx/aicasm fails to build
References: <20031205093800.GV754@charite.de>
In-Reply-To: <20031205093800.GV754@charite.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:
> Hi!
> 
> When I try to build 2.4.23, I get:
> 
> ...
> /usr/bin/make -C scsi
> make[3]: Entering directory /usr/src/linux-2.4.23/drivers/scsi'
> /usr/bin/make -C aic7xxx
> make[4]: Entering directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx'
> /usr/bin/make all_targets
> make[5]: Entering directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx'
> /usr/bin/make -C aicasm
> make[6]: Entering directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx/aicasm'
> yacc -d -b aicasm_gram aicasm_gram.y
> mv aicasm_gram.tab.c aicasm_gram.c
> mv aicasm_gram.tab.h aicasm_gram.h
> yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
> mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
> mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
> lex  -oaicasm_scan.c aicasm_scan.l
> lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
> gcc -I/usr/include -I. aicasm.c aicasm_symbol.c aicasm_gram.c aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm -ld
> aicasm_gram.y:1933: warning: type mismatch with previous implicit declaration
> aicasm_gram.tab.c:3055: warning: previous implicit declaration of yyerror'
> aicasm_gram.y:1933: warning: yyerror' was previously implicitly declared to return int'
> aicasm_macro_gram.y:162: warning: type mismatch with previous implicit declaration
> aicasm_macro_gram.tab.c:1275: warning: previous implicit declaration of mmerror'
> aicasm_macro_gram.y:162: warning: mmerror' was previously implicitly declared to return int'
> aicasm_scan.l: In function expand_macro':
> aicasm_scan.l:522: error: yytext_ptr' undeclared (first use in this function)
> aicasm_scan.l:522: error: (Each undeclared identifier is reported only once
> aicasm_scan.l:522: error: for each function it appears in.)
> make[6]: *** [aicasm] Error 1
> make[6]: Leaving directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx/aicasm'
> make[5]: *** [aicasm/aicasm] Error 2
> make[5]: Leaving directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx'
> make[4]: *** [first_rule] Error 2
> make[4]: Leaving directory /usr/src/linux-2.4.23/drivers/scsi/aic7xxx'
> make[3]: *** [_subdir_aic7xxx] Error 2
> make[3]: Leaving directory /usr/src/linux-2.4.23/drivers/scsi'
> make[2]: *** [_subdir_scsi] Error 2
> make[2]: Leaving directory /usr/src/linux-2.4.23/drivers'
> make[1]: *** [_dir_drivers] Error 2
> make[1]: Leaving directory /usr/src/linux-2.4.23'
> make: *** [stamp-build] Error 2
> 
Ralf,

I believe if you turn off
CONFIG_AIC7XXX_BUILD_FIRMWARE in your config, it should build.

Ethan

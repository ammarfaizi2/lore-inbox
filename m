Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHAWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHAWAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWHAWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:00:22 -0400
Received: from terminus.zytor.com ([192.83.249.54]:58596 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751172AbWHAWAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:00:21 -0400
Message-ID: <44CFCEE7.10406@zytor.com>
Date: Tue, 01 Aug 2006 15:00:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: sam@ravnborg.org, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@mars.ravnborg.org>
Subject: Re: [PATCH] kbuild: hardcode value of YACC&LEX for aic7-triple-x
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <20060729090725.GF6843@martell.zuzino.mipt.ru>
In-Reply-To: <20060729090725.GF6843@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Sat, Jul 29, 2006 at 09:19:33AM +0200, sam@ravnborg.org wrote:
>> When we introduced -rR then aic7xxx no loger could pick up definition
>> of YACC&LEX from make - so do it explicit now.
> 
>> --- a/drivers/scsi/aic7xxx/aicasm/Makefile
>> +++ b/drivers/scsi/aic7xxx/aicasm/Makefile
>> @@ -14,6 +14,8 @@ LIBS=	-ldb
>>  clean-files:= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output) $(PROG)
>>  # Override default kernel CFLAGS.  This is a userland app.
>>  AICASM_CFLAGS:= -I/usr/include -I.
>> +LEX= flex
>> +YACC= bison
>>  YFLAGS= -d
>>  
>>  NOMAN=	noman
> 
> SuSv3 lists "lex" and "yacc" as _the_ names. Is there any distro which
> doesn't install compat symlinks?
> 

At least on Red Hat/Fedora, "yacc" invokes BSD yacc, which produces 
worse code than bison.

	-hpa

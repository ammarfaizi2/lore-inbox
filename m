Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWGIS3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWGIS3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGIS3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:29:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2975 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932375AbWGIS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:29:20 -0400
Message-ID: <44B14AEB.2060902@zytor.com>
Date: Sun, 09 Jul 2006 11:28:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 build error (YACC): followup
References: <20060707202442.DA2AFDBA1@gherkin.frus.com> <20060707223650.GB28811@mars.ravnborg.org> <44AEF43A.5020308@zytor.com> <20060709133844.GA6650@mars.ravnborg.org>
In-Reply-To: <20060709133844.GA6650@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jul 07, 2006 at 04:54:34PM -0700, H. Peter Anvin wrote:
>> I propose the following as a global yacc rule; already used in usr/dash 
>> in the klibc tree, and which seems to work for both bison and BSD yacc:
>>
>> quiet_cmd_yacc = YACC    $@
>>       cmd_yacc = $(YACC) -d -o $@ $<
>>
>> $(obj)/%.c %(obj)/%.h: $(src)/%.y
>>         $(call cmd,yacc)
> klibc and the kernel does not share any rules today.
> And yacc is so special that it's not worth it only for yacc to start
> doing this.
> 
> In todays kernel build yacc is never used. For the few cases were output
> of yacc is needed the kernel include _shipped files. For dash we should
> maybe consider the same?
> 

Personally I consider that pretty silly.  yacc/bison is a standard, 
portable utility, and it isn't even architecture-dependent so there is 
no porting effort.

	-hpa

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTBUU7S>; Fri, 21 Feb 2003 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTBUU7S>; Fri, 21 Feb 2003 15:59:18 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:21778 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267696AbTBUU7R>; Fri, 21 Feb 2003 15:59:17 -0500
Message-ID: <3E569566.9080201@didntduck.org>
Date: Fri, 21 Feb 2003 16:08:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sudharsan Vijayaraghavan <svijayar@cisco.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Accessibility of variables between kernel modules
References: <4.3.2.7.2.20030222004531.00b56fb0@desh>
In-Reply-To: <4.3.2.7.2.20030222004531.00b56fb0@desh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sudharsan Vijayaraghavan wrote:
> Hi,
> 
> Am using 2.4 kernel . In this release i find that all non-static symbols
> ( functions/variables) defined in one kernel module are exported by 
> default to other kernel modules .
> If we would use EXPORT_NO_SYMBOLS this exporting of symbols is prevented 
> . However we can export one of the symbols in one module using 
> EXPORT_SYMBOL and then prevent the export of others by immediately 
> calling EXPORT_NO_SYMBOLS.
> 
> We can even use EXPORT_SYMBOL_GPL to export a symbol from a given module 
> , these could be accessed by
> only those modules using MODULE_LICENSE() and are GPL compatible.
> 
> However my requirement is quite different. It is as follows.
> 
> I have two kernel modules A and B. Is it possible that the variables in 
> kernel module A should only be visible to kernel module B and no other 
> kernel modules in the system.
> If so please help me out with some explanation.
> Really appreciate your help regarding the same.
> 
> Thanks in advance,
> Sudharsan.

Exported symbols are always global.  If you want to make sure there are 
no symbol conflicts the variable names must be unique.  Other than the 
GPL symbols, there is no way of preventing other modules from using 
exported symbols.

--
				Brian Gerst



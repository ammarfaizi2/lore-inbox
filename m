Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbTIDNof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbTIDNof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:44:35 -0400
Received: from gharelay-av-smtp1.gmessaging.net ([194.51.201.2]:31175 "EHLO
	eads-av-smtp1.gmessaging.net") by vger.kernel.org with ESMTP
	id S264983AbTIDNod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:44:33 -0400
Date: Thu, 04 Sep 2003 15:44:29 +0200
From: Yann Droneaud <yann.droneaud@mbda.fr>
Subject: Re: nasm over gas?
In-reply-to: <20030904104245.GA1823@leto2.endorphin.org>
To: fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5741BD.5000401@mbda.fr>
Organization: MBDA
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr-fr, fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030612
References: <20030904104245.GA1823@leto2.endorphin.org>
X-OriginalArrivalTime: 04 Sep 2003 13:42:30.0966 (UTC)
 FILETIME=[63418D60:01C372EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fruhwirth clemens wrote:

> Hi!
> 
> I recently posted a module for twofish which implements the algorithm in
> assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> 
> Unfortunately the assembler used is masm. I'd like to change that. Netwide
> Assembler (nasm) is the assembler of my choice since it focuses on
> portablity and has a more powerful macro facility (macros are heavily used
> by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> inclusion in the kernel) I noticed that this would be the first module to
> depend on nasm. Everything else uses gas.
> 
> So the question is: Is a patch which depends on nasm likely to be merged?
> 

I hope no ...

Some years ago, we converted the only part of the kernel that used as86
to GNU as: see arch/i386/boot. I think this was an improvement.
Using nasm for only one small piece of code would be a regression, imho.

Regards.

PS: GCC pass .S assembler source files through cpp, so you get macros
expanding.

-- 
Yann Droneaud <yann.droneaud@mbda.fr>
<ydroneaud@meuh.eu.org> <meuh@tuxfamily.org>


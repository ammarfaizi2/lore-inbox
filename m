Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVGTRmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVGTRmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVGTRmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:42:17 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:20438 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261426AbVGTRls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:41:48 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: kernel guide to space
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux@horizon.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 20 Jul 2005 19:42:45 +0200
References: <4q0yr-4YQ-3@gated-at.bofh.it> <4sdKS-7Ko-9@gated-at.bofh.it> <4shEU-25p-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DvIak-0006Fa-Au@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>> 3)  If a normal line of code is more than 80 characters, one of the
>> following is probably true: you need to break the line up and use temps
>> for clarity, or your function is so big that you're tabbing over too
>> far.
> 
> (Find source files, expand tab chars to their on-screen length, print if
>>= 80, count lines)
> 
> ~/linux-2.6.12 >
>   find . -type f "(" -iname "*.c" -o -iname "*.h" -o -iname "*.S" ")"

... -exec expand -t 8 '{}' \; | egrep '^.{80}' | wc -l

 233941

You didn't take \t[^\t]\t into account.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

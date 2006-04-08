Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWDHXfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWDHXfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 19:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWDHXfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 19:35:18 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:23513 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751440AbWDHXfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 19:35:17 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hpa@zytor.com, mm-commits@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 09 Apr 2006 01:34:42 +0200
References: <5Zs4F-ba-13@gated-at.bofh.it> <5Zs4F-ba-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FSMxM-0001Ir-1J@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sat, Apr 08, 2006 at 12:05:54AM -0700, akpm@osdl.org wrote:

>> diff -puN usr/dash/mkbuiltins~git-klibc-mktemp-fix usr/dash/mkbuiltins
>> --- 25/usr/dash/mkbuiltins~git-klibc-mktemp-fix      Sat Apr  8 14:51:11 2006
>> +++ 25-akpm/usr/dash/mkbuiltins      Sat Apr  8 14:51:11 2006

>> -    tempfile=mktemp
>> +    tempfile="mktemp /tmp/tmp.XXXXXX"
> 
> Shouldn't that be:
>> +    tempfile="$(mktemp /tmp/tmp.XXXXXX)"

No. You should use tempfile="$(mktemp ${TMPDIR:-/tmp}/tmp.XXXXXX)"
(or mktemp -t, if it's portable enough)

Besides that, tmp.XXXXXX should be replayed using a better name.

</nitpick>
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVITIJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVITIJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVITIJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:09:57 -0400
Received: from [213.132.87.177] ([213.132.87.177]:37807 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S964924AbVITIJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:09:56 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: thayumk@gmail.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kbuild
Date: Tue, 20 Sep 2005 12:13:44 +0400
User-Agent: KMail/1.8
References: <200509191432.58736.dr_unique@ymg.ru> <3b8510d805092000346c27270f@mail.gmail.com> <3b8510d80509200043e09eae9@mail.gmail.com>
In-Reply-To: <3b8510d80509200043e09eae9@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509201213.44638.dr_unique@ymg.ru>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2005 08:17:24.0498 (UTC) FILETIME=[BB11FF20:01C5BDBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thayumanavar Sachithanantham wrote:
> Let me know your results.Take care of the quotes while you change.

make -C ../../../linux-2.6.11.4-21.8
 O=../linux-2.6.11.4-21.8-obj/i386/default /bin/sh: -c: line 0: syntax error
 near unexpected token `('
/bin/sh: -c: line 0: `set -e;
.....

What symbol must be between
-D'DUM(a)=\#a'
and
-D'KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))')

?

I tried a space, comma and no spaces, also with quotes and without any, but
got an error above.

Here is my line:
modname_flags  = $(if $(filter 1,$(words $(modname))),-D'DUM(a)=\#a'
-D'KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))')

-- 
RomanU

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270528AbRHISRJ>; Thu, 9 Aug 2001 14:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270543AbRHISQ7>; Thu, 9 Aug 2001 14:16:59 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:10510 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S270536AbRHISQs>; Thu, 9 Aug 2001 14:16:48 -0400
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat write wrong value into lcase flag
In-Reply-To: <87wv4er2kt.fsf@devron.myhome.or.jp>
	<200108082020.WAA1347968@mail.takas.lt>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 10 Aug 2001 03:16:34 +0900
In-Reply-To: <200108082020.WAA1347968@mail.takas.lt>
Message-ID: <874rrhf69p.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas <nerijus@users.sourceforge.net> writes:

> On 09 Aug 2001 00:30:58 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> 
> OH> The current vfat is writeing wrong value into lcase flag.  It is
> OH> writing the lowercase flag, although filename is uppercase.
> 
> Hello,
> 
> In December 1999 I sent my investigation about short filenames in vfat:

[...]

> 
> I think Linux should create files like win98
> (because NT shows them correctly) and show like NT.

The _current vfat_ uses the following rule.

  name                   attribute                         used direntry
-----------------------------------------------------------------------------
foo.txt  LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2
foo.TXT  LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2
FOO.txt  LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2
FOO.TXT               , CASE_LOWER_BASE | CASE_LOWER_EXT         1
Foo.TXT  LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2
FOO.Txt  LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2

I missed something?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


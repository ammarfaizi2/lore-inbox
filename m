Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVFPJkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVFPJkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFPJkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 05:40:22 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:63684 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261524AbVFPJkO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 05:40:14 -0400
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>
	<200506150454.11532.pmcfarland@downeast.net>
	<42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>
	<42B04090.7050703@poczta.fm>
	<20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Thu, 16 Jun 2005 11:40:10 +0200
In-Reply-To: <42B0BAF5.106@poczta.fm> (Lukasz Stelmach's message of "Thu, 16
 Jun 2005 01:34:13 +0200")
Message-ID: <yw1xll5a1vyd.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Stelmach <stlman@poczta.fm> writes:

> Lennart Sorensen napisał(a):
>
>>>And it is good in a way, however, i think kernel level translation
>>>should be also possible. Either done by a code in each filsystem or by
>>>some layer above it.
>> 
>> What do you do if the underlying filesystem can not store some unicode
>> characters that are allowed on others?
>
> That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
> software that need not to be aware of unicodeness of the text it manages
> to handle it without any hickups *and* to store in the text information
> about multibyte characters.What characters exactly you do mean? NULL?
> There is no NULL byte in any UTF-8 string except the one which
> terminates it.

That's exactly how ext3, reiserfs, xfs, jfs, etc. all work.  A few
filesystems are tagged as using some specific encoding.  If your
filesystem is marked for iso-8859-1, what should a kernel with a
conversion mechanism do if a user tries to name a file 김?

>> I think UDF is a better filesystem for many types of media since it is
>> able to me more gently to the sectors storing the meta data than VFAT
>> ever will be.
>
> I've tried cd packet writing with UDF and it gives insane overhead of
> about 20%. What metadata you'd like to store for example on your
> flashdrive or a floppy disk?

Filename, timestamps, all the usual.

-- 
Måns Rullgård
mru@inprovide.com

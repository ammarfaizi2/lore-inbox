Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFOJlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFOJlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFOJlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:41:50 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:1784 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261367AbVFOJlq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:41:46 -0400
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>
	<200506150454.11532.pmcfarland@downeast.net>
	<42AFF184.2030209@poczta.fm>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 15 Jun 2005 11:41:42 +0200
In-Reply-To: <42AFF184.2030209@poczta.fm> (Lukasz Stelmach's message of
 "Wed, 15 Jun 2005 11:14:44 +0200")
Message-ID: <yw1xd5qo2bzd.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Stelmach <stlman@poczta.fm> writes:

> Patrick McFarland napisał(a):
>> On Wednesday 15 June 2005 04:26 am, Lukasz Stelmach wrote:
>> 
>>>Måns Rullgård napisał(a):
>>>
>>>>I use utf-8 exclusively for my filenames (the few that are not 7-bit
>>>>ascii).  Forcing others who use the system to do the same would cause
>>>>them a lot of trouble, as they must transfer files to and from Windows
>>>>machines that use anything but utf-8.
>>>
>>>But VFAT (and NTFS???) use unicode, i.e. UTF-16 (???). AFAIK
>> 
>> No, VFAT and NTFS use an 8-bit encoding,
>
> I meant that they don't use utf-8 but it is still the unicode. I am not
> sure i've made myself clear.
>
>> Forcing people to use unicode isn't a bad thing btw, especially since
>> it is a culture agnostic encoding that can represent wide characters
>> (eg. from Asian languages) in a uniform manner*, and allowing to use
>> multiple languages (eg. Chinese and Japanese) at once without needing
>> to switch encodings.
>
> Yes. I also think UTF-8 is a good idea, however it is not an ideal one.
> It *preferes* Roman encodings since some Asian characters need even four
> bytes.

That's a simple consequence of having an alphabet with thousands of
characters.  Besides, fewer of the Asian characters are required to
represent the same meaning, so the byte count should come out about
the same.

> IMHO for *every* filesystem there need to be an *option* to:
>
> 1. store filenames in utf-8 (that is quite possible today) or any other
> unicode form.

export LC_CTYPE=whatever.utf-8

> 2. convert them to/from a desired iocharset. I prefere using ISO-8859-2
> on my system for not every tool support utf-8 today (hopefuly yet).

man iconv

> Of course if a user whishes to store filenames in some other encoding
> she should be *able* to do so (that is why i like linux).

That's the current situation.

> Generally. IMHO VFAT is a good example how character encoding needs
> to be handeled.

IMHO, VFAT is only a good example of bad design.

-- 
Måns Rullgård
mru@inprovide.com

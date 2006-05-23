Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWEWBCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWEWBCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWEWBCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:02:38 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:44778 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S1751214AbWEWBCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:02:37 -0400
Message-ID: <44725F26.3080802@iparadigms.com>
Date: Mon, 22 May 2006 18:02:30 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Re: tuning for large files in xfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return-Path: <news@google.com>
X-Original-To: linux-kernel@moderators.bofh.it
Delivered-To: linuxmod+linux.kernel@attila.bofh.it
Received: from horus.isnic.is (horus.isnic.is [193.4.58.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by attila.bofh.it (Postfix) with ESMTP id 057865F87F
	for <linux-kernel@moderators.bofh.it>; Tue, 23 May 2006 02:59:46 +0200 
(CEST)
Received: from proxy.google.com (proxy.google.com [66.102.0.4])
	by horus.isnic.is (8.12.9p2/8.12.9/isnic) with ESMTP id k4N0xduC097233
	for <linux-kernel@moderators.isc.org>; Tue, 23 May 2006 00:59:41 GMT
	(envelope-from news@google.com)
Received: from  G018037
	by proxy.google.com with ESMTP id k4N0xXAA020036
	for <linux-kernel@moderators.isc.org>; Mon, 22 May 2006 17:59:33 -0700
Received: (from news@localhost)
	by Google Production with  id k4N0xXvP022170
	for linux-kernel@moderators.isc.org; Mon, 22 May 2006 17:59:33 -0700
To: linux-kernel@moderators.isc.org
Path: j73g2000cwa.googlegroups.com!not-for-mail
From: fitzboy@iparadigms.com
Newsgroups: linux.kernel
Subject: Re: tuning for large files in xfs
Date: 22 May 2006 17:59:27 -0700
Organization: http://groups.google.com
Lines: 12
Message-ID: <1148345967.616414.318940@j73g2000cwa.googlegroups.com>
References: <6fnNu-7ae-23@gated-at.bofh.it> <6fr4D-3JP-7@gated-at.bofh.it>
NNTP-Posting-Host: 209.209.36.196
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Trace: posting.google.com 1148345973 22160 127.0.0.1 (23 May 2006 
00:59:33 GMT)
X-Complaints-To: groups-abuse@google.com
NNTP-Posting-Date: Tue, 23 May 2006 00:59:33 +0000 (UTC)
In-Reply-To: <6fr4D-3JP-7@gated-at.bofh.it>
User-Agent: G2/0.2
X-HTTP-Useragent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) 
AppleWebKit/418 (KHTML, like Gecko) Safari/417.9.2,gzip(gfe),gzip(gfe)
Complaints-To: groups-abuse@google.com
Injection-Info: j73g2000cwa.googlegroups.com; posting-host=209.209.36.196;
    posting-account=4elvtg0AAAAA6DoPt8oOAEoKYVdVm_2h

the sweet size for me would be a 32k block size on both the RAID and
the XFS partition for me (that is the best number for my application).
However, on the lower level RAID there is a very nominal performance
difference between 32k and 64k stripe size (like 4%), so I just stick
with the defauly 64k. And for the XFS partition, since I am on an intel
machine with 2.6.8, I can only go up to a 2k blocksize...

But to answer your question, the RAID is on a 64k stripe size, and I
just changed my test app to do 2k reads, and still I get the same
performance (with only marginal improvement), so alignment can't be the




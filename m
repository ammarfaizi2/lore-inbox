Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWBLDe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWBLDe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 22:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWBLDe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 22:34:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:36547 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750828AbWBLDe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 22:34:28 -0500
Message-ID: <43EEACA7.5020109@zytor.com>
Date: Sat, 11 Feb 2006 19:33:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "'austin-group-l@opengroup.org'" <austin-group-l@opengroup.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: The naming of at()s is a difficult matter
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that the new ...at() system calls are named in what
appears to be a completely haphazard fashion.  In Unix system calls,
an f- prefix means it operates on a file descriptor; the -at suffix (a
prefix would have been more consistent, but oh well) similarly
indicates it operates on a (directory fd, pathname) pair.

However, some system calls, in particular fchownat, futimesat,
fchmodat and faccessat add the f- prefix for what appears to be
absolutely no good reason.  Logically, these system calls should be
named chownat, utimesat, chmodat, and accessat.

I understand some of this braindamage comes from Solaris, but some of
these calls do not.  We should avoid it if at all possible, and I
would recommend at least introducing aliases with the sane names.

         -hpa

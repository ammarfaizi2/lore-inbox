Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVLGOB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVLGOB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVLGOB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:01:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751053AbVLGOB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:01:27 -0500
Message-ID: <4396EB2F.3060404@redhat.com>
Date: Wed, 07 Dec 2005 09:01:19 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: another nfs puzzle
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
In-Reply-To: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson wrote:

>Hi again,
>  I am seeing some odd behavior with O_DIRECT.  If a file opened with O_DIRECT has a page mmap'd,
>and the file is extended via pwrite, then the mmap'd region seems to get lost - i.e. it neither
>takes up system memory, nor does it get written out.
>  
>

I don't think that I understand why or how the kernel allows a file,
which was opened with O_DIRECT, to be mmap'd.  The use of O_DIRECT
implies no caching and mmap implies the use of caching.

I do understand that the kernel can flush and invalidate pages in
the ranges of the i/o operations done, but does it really guarantee
that a pagein operation won't happen on a page within the range of
a region of the file being written to using direct i/o?  If it does
not, then any consistency guarantees are gone and data corruption
can occur.

    Thanx...

       ps

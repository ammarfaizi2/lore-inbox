Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFJWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFJWOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFJWOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:14:06 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:36324 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261274AbVFJWOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:14:00 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: slow directory listing
To: Ron Peterson <rpeterso@mtholyoke.edu>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 11 Jun 2005 00:12:52 +0200
References: <4dSQ6-1vz-27@gated-at.bofh.it> <4dTCx-2d8-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DgrkL-00029X-HW@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson <rpeterso@mtholyoke.edu> wrote:
> On Fri, Jun 10, 2005 at 10:37:20AM -0400, rpeterso wrote:

>> I'm setting up a new mail server, and am testing/tweaking IO.  I have
>> two directories: /test/a which contains 750 mbox files totalling 8GB,
>> and /test/a2, which contains the exact same number of files, same names,
>> all zero length.
>> ...
>> The times taken to do a directory listing are significantly different.
> 
> I've become more confused, if that's possible.  I was just editing some
> test script in emacs.  As part of the script creation process I used the
> M-! command to pipe the output of 'ls /test/a' into a buffer.  It
> snapped back almost instantly.

Try ls|cat and take a look at $LS_OPTIONS and $LS_COLORS. I suspect your
ls tries to use some magic on the files to determine the color.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

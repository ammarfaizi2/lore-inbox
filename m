Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULAAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULAAfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbULAAeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:34:22 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:62917 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261199AbULAAX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:23:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Wed, 1 Dec 2004 00:23:24 +0000 (UTC)
Organization: Cistron Group
Message-ID: <coj2ts$hhp$1@news.cistron.nl>
References: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org> <20041130225128.GA31216@infradead.org> <41ACFDAF.3040209@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1101860604 17977 62.216.29.200 (1 Dec 2004 00:23:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41ACFDAF.3040209@nortelnetworks.com>,
Chris Friesen  <cfriesen@nortelnetworks.com> wrote:
>Christoph Hellwig wrote:
>
>>>b) when include/user is deemed sufficiently populated, a flag day is
>>>declared and links from /usr/include are switched to them
>> 
>> 
>> there are no such links, only copies (more or less modified)
>
>This may be somewhat heretical, but someone has to ask...
>
>Once include/user/foo.h is sufficiently clean and sufficiently complete, is 
>there any reason to not allow such links?

It would be cleaner to use gcc -I /lib/modules/`uname -r`/build/include
so that you don't break regular compiles by accident.

Mike.


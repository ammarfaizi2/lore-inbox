Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUHKRGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUHKRGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHKRGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:06:18 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:53010 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S268114AbUHKRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:05:59 -0400
Message-ID: <411A4D34.6000104@lougher.demon.co.uk>
Date: Wed, 11 Aug 2004 17:45:40 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: leiyang@nec-labs.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Compression algorithm in cloop
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Hello,
 >
 > I am trying to do some experiment on compression ratios with cloop. I
 > know that currently cloop uses zlib. How can I change it to other
 > algorithms?

Changing the algorithm from gzip is going to be probably unpopular.
Cloop uses the gzip deflate library inside the kernel shared by a
large number of other programs.  To change the algorithm you'll have
to add more (private) decompression code to the kernel.  This is a retrograde
step because the shared library was only introduced in 2.4.17 to avoid lots
of private copies of gzip.

 > Where should I start from? Really a newbie to this,
 > appreciate any comments and suggestions!!

There has been discussion on this list before about adding
bzip2 support to the kernel.  Do a search on the list for this.

Regards

Phillip


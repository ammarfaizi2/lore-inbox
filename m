Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUFSTQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUFSTQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSTQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:16:57 -0400
Received: from quechua.inka.de ([193.197.184.2]:65170 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262050AbUFSTQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:16:56 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: mode data=journal in ext3. Is it safe to use?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <1087558255.25904.14.camel@pmarqueslinux>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BblKg-0007Mn-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 19 Jun 2004 21:16:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1087558255.25904.14.camel@pmarqueslinux> you wrote:
> The point is, there is no concept of "atomic operation" at the file
> system level, so the application must do journaling itself if it wants
> to have some concept of "transactions".

Well, there can be rules like  "writes after flush with size less than x are
atomic". With X beeing something between sector size, blocksize or data
journal size.

However most unix programs  which do not do yournalling and rely on some
stable atomic behaviour work with generating new files and renaming that.
And for this the meta data journalling in ordered mode is fine. 

So only the append only logfiles may need some special treatment, this looks
like a common source for null-bytes in a file. And only in case it is not a
temp file, its a problem (syslog)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/

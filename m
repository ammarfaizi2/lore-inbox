Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUE0HEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUE0HEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 03:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUE0HEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 03:04:36 -0400
Received: from quechua.inka.de ([193.197.184.2]:40872 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261631AbUE0HEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 03:04:35 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200405270014.10096.tcfelker@mtco.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BTEwL-0007lu-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 27 May 2004 09:04:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200405270014.10096.tcfelker@mtco.com> you wrote:
> O_STREAMING and a flag to not cache a file when it closes are a good start.  

Win32 API has a FILE_ATTRIBTE_TEMPORARY to mark files which should be
prefered be served from buffercache, FIL_FLAG_NO_BUFFERING allows raw access
(required block boundary reads). FILE_FLAG_RANDOM_ACCESS is used to hint the
cache (dont know what it does, maybe reduce prefetching?) as well als
FILE_FLAG_SEQUENTIAL_SCAN as a hint for the other case where you read the
stream. There is also a writethrough flag, which does not affect caching. So
basically I think the hints Win32 API offers are not the perfect set of
flags one can think about. Unless SEQUENTIAL_ACCESS implies also "forget
blocks vefore current read position".

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/

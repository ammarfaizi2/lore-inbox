Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVC2UeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVC2UeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVC2Ud7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:33:59 -0500
Received: from justchat.medium.net ([83.120.2.52]:11401 "EHLO
	smtp.mail.service.medium.net") by vger.kernel.org with ESMTP
	id S261411AbVC2Ucg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:32:36 -0500
Message-ID: <4249BB5C.5000102@baldauf.org>
Date: Tue, 29 Mar 2005 22:32:28 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a5) Gecko/20041122
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: vfat: why is shortname=lower the default?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.5 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hirofumi,

Why is shortname=lower the default mount option for vfat filesystems? 
Because, with "shortname=lower", copying one FAT32 filesystem tree to 
another FAT32 filesystem tree using Liux results in semantically 
different filesystems. (E.g.: Filenames which were once "all uppercase" 
are now "all lowercase").

With "shortname=mixed", such semantic changes would not occur. That's 
why I'd consider "shortname=lower" as default mount option as a bug. I'd 
propose "shortname=mixed" as default as a fix for this bug.

What do you think?

ciao,
Xuân.


P.S.: "man mount" says:

       shortname=[lower|win95|winnt|mixed]

              Defines the behaviour for creation and display of 
filenames which fit into 8.3 characters. If a long name for a file 
exists, it will always be preferred display. There are four modes:

              lower  Force the short name to lower case upon display; 
store a long name when the short name is not all upper case.

              win95  Force the short name to upper case upon display; 
store a long name when the short name is not all upper case.

              winnt  Display the shortname as is; store a long name when 
the short name is not all lower case or all upper case.

              mixed  Display the short name as is; store a long name 
when the short name is not all upper case.

       The default is "lower".


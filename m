Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUKZS7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUKZS7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKZS7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 13:59:38 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40182 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261152AbUKZS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 13:59:29 -0500
Message-ID: <41A773CD.6000802@namesys.com>
Date: Fri, 26 Nov 2004 10:19:57 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <1101287762.1267.41.camel@pear.st-and.ac.uk>	 <4d8e3fd304112407023ff0a33d@mail.gmail.com>	 <200411241711.28393.christian.mayrhuber@gmx.net> <1101379820.2838.15.camel@grape.st-and.ac.uk>
In-Reply-To: <1101379820.2838.15.camel@grape.st-and.ac.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>
>The problem with the
>cat /etc/passwd/..metas/contents/shell[username = "joe"]
>syntax is that it doesn't really achieve namespace unification.
>
>
>
>
>  
>
For the case Peter cites, yes, it does add clutter to the pathname to 
say "..metas" (actually, it is "...." now in the current reiser4, not 
"..metas").  This is because you aren't looking for metafile 
information, you are looking for a subset and describing the subset, and 
that just requires a file-directory plugin that can handle the name of 
that subset and parse the file to find it.

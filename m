Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTF2UFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTF2UFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:05:49 -0400
Received: from post.pl ([212.85.96.51]:38157 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S264884AbTF2UFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:05:42 -0400
Message-ID: <3EFF4A70.2010505@post.pl>
Date: Sun, 29 Jun 2003 22:22:08 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <200306291431080580.01CF24BF@smtp.comcast.net> <3EFF4443.8080507@sktc.net>
In-Reply-To: <3EFF4443.8080507@sktc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:
> Funny how, having never used LVM you have an opinion about it.
> 
> I have. I have done EXACTLY what I described.
> 
> First of all, do you REALLY think my way is any less failure prone, 
> especially in the presence of the possiblilty of power failure than any 
> other method? My method preserves a mountable, valid file system at each 
> step of the way - the resized downward of the old file system, the 
> resize upward of the new, the file copy.
> 
> Secondly, if you are REALLY concerned about the manual aspect of what I 
> suggested, you can write a simple shell script to do the work.
> 
> Third of all, the longest parts of the process I describe will be the 
> resize downward of the old file system and the copy of the data - the 
> LVM parts of this operation are pretty damn quick.

Yes, and I think it is the right way to follow. If we ensure, that each 
of described steps preserves filesystem integrity we could automate this 
thus getting what was described in initial idea but simpler. Yet better 
- there is code that solves nearly all problems, there is only need to 
automate fiddling with partitions and LVM, so end user will see this as 
real transparent :-)

-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen


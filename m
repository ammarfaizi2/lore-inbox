Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTGAOkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAOkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:40:43 -0400
Received: from post.pl ([212.85.96.51]:5893 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S262373AbTGAOjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:39:32 -0400
Message-ID: <3F01A0FE.6060403@post.pl>
Date: Tue, 01 Jul 2003 16:55:58 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.org.au>
CC: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl> <3EFF4177.6000705@post.pl> <200306291548060930.02159FEE@smtp.comcast.net> <20030701101509.GC3587@cancer>
In-Reply-To: <20030701101509.GC3587@cancer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stewart Smith wrote:
> Yes it is. In fact, it is more of a problem then you think.
> 
> Think of this simple scenario:
> a script is running that downloads a kernel patch, applies it to a tree,
> then renames the directory to $1-$patchname.
> 
> Half way through this, during the patch, the backup script comes through
> and starts to backup the filesystem.
> 
> 
> Now - wipe the drive clean at the end and restore it to a sane state.
> 
> Doing live things on storage systems without transactions, snapshots or
> whatever you want to call them is tricky at best. resizing is going to 
> cause headaches.
> 

I think of some sort of overlay filesystem on top of that *thing*. In
this case ovarlay filesystem could serve as redo log in database system.
Then we need only worry with read operations, not write. Writes will be
stored in redo log, and eventually they will be included when actual
read only filesystem will be converted.

What you think about this?



-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen


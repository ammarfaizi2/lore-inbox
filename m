Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSDQO1o>; Wed, 17 Apr 2002 10:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSDQO1n>; Wed, 17 Apr 2002 10:27:43 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:45991 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314043AbSDQO1n>; Wed, 17 Apr 2002 10:27:43 -0400
Subject: Callbacks to userspace from VFS ?
From: Martin Rode <martin.rode@programmfabrik.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 16:21:13 +0200
Message-Id: <1019053273.8655.109.camel@marge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers,

after programming at least 10 scripts polling a what we call
"hot-folder" for new files I had the idea to integrate call backs into
the file system layer of the linux kernel.

I would like to tell the kernel to callback my program whenever a file
or directory is being inserted, updated or deleted.

A simple approach could look like this (from the users POV):

mount -o callback=/tmp/myprogram callback_options=some_options
callback_folder=hotfolder callback_folder=hotfolder2 /dev/some /home

depending on what has happend in "hotfolder" or "hotfolder2" the
"myprogram" would be started and receive the two arguments:

DELETE filename of the file deleted
UPDATE filename
INSERT filename

It would be neat if one could change the mount options while the
filesystem is mounted.

If you could implement such a feature we had another great argument why
the linux kernel has something to offer which others haven't. With such
a feature one could program solutions for the real world which are
always annoying to program (cue: "hotfolder"!).

What do you people think about the idea? Please reply to me personally,
too, I'm not a subscriber.

Thanks for taking a look at the idea.

;Martin



-- 
                  Dipl.-Kfm. Martin Rode                    
                     Managing Director

                martin.rode@programmfabrik.de                  

Programmfabrik GmbH                 Fon +49-(0)30-4281-8001
Frankfurter Allee 73d               Fax +49-(0)30-4281-8008
10247 Berlin                        Funk +49-(0)163-5321400
 
                http://www.programmfabrik.de/
 





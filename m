Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSDQOpg>; Wed, 17 Apr 2002 10:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDQOpf>; Wed, 17 Apr 2002 10:45:35 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:54158 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S314096AbSDQOpe>; Wed, 17 Apr 2002 10:45:34 -0400
Date: Wed, 17 Apr 2002 16:45:19 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Martin Rode <martin.rode@programmfabrik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Callbacks to userspace from VFS ?
Message-ID: <20020417164519.A16717@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Martin Rode <martin.rode@programmfabrik.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1019053273.8655.109.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

try reading Documentation/dnotify.txt. Maybe it'll be enough for you.

-alex

On Wed, Apr 17, 2002 at 04:21:13PM +0200, Martin Rode wrote:
> Dear kernel hackers,
> 
> after programming at least 10 scripts polling a what we call
> "hot-folder" for new files I had the idea to integrate call backs into
> the file system layer of the linux kernel.
> 
> I would like to tell the kernel to callback my program whenever a file
> or directory is being inserted, updated or deleted.
> 
> A simple approach could look like this (from the users POV):
> 
> mount -o callback=/tmp/myprogram callback_options=some_options
> callback_folder=hotfolder callback_folder=hotfolder2 /dev/some /home
> 
> depending on what has happend in "hotfolder" or "hotfolder2" the
> "myprogram" would be started and receive the two arguments:
> 
> DELETE filename of the file deleted
> UPDATE filename
> INSERT filename
> 
> It would be neat if one could change the mount options while the
> filesystem is mounted.
> 
> If you could implement such a feature we had another great argument why
> the linux kernel has something to offer which others haven't. With such
> a feature one could program solutions for the real world which are
> always annoying to program (cue: "hotfolder"!).
> 
> What do you people think about the idea? Please reply to me personally,
> too, I'm not a subscriber.
> 
> Thanks for taking a look at the idea.
> 
> ;Martin

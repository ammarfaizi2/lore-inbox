Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCKVgl>; Mon, 11 Mar 2002 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCKVgb>; Mon, 11 Mar 2002 16:36:31 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:62606 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293161AbSCKVgQ>; Mon, 11 Mar 2002 16:36:16 -0500
Message-Id: <200203112048.NAA12104@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Hans Reiser <reiser@namesys.com>, elenstev@mesatop.com
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 14:33:55 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <200203111755.KAA11787@tstac.esa.lanl.gov> <3C8D0260.8070700@namesys.com>
In-Reply-To: <3C8D0260.8070700@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 12:15 pm, Hans Reiser wrote:
> Steven Cole wrote:
> >I fiddled around a bit with VMS, and it looks like the following command
> > set things up for me so that I only have one version for any new files I
> > create:
> >
> >SET DIRECTORY/VERSION_LIMIT=1 SYS$SYSDEVICE:[USERS.STEVEN]
> >
> >This change was persistant across logins.  Hope this helps.
> >
> >Steven
>
> This affects all directories and all files for user steven, or just one
> directory?

The above example affected all subsequently created files and subsequently
created directories under user steven, such as DKA300:[USERS.STEVEN.TESTTHIS].
Previously created directories retain their previous version_limit setting, which
I checked in DKA300:[USERS.STEVEN.HELLOWORLD].  Previously created files also
retain their previous version_limit setting.

I also set the version_limit for the whole disk (as SYSTEM) with 
SET DIRECTORY/VERSION_LIMIT=1 DKA300:[000000], but again this only affected
subsequently created files and directories along with the files they contain.

I have not figured out how to set the version_limit retroactively; perhaps it is
not possible with a simple command.  Obviously, you could do this with a DCL 
script if you really wanted to.

Steven

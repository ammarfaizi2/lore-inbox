Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRK0HpS>; Tue, 27 Nov 2001 02:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282847AbRK0Hnm>; Tue, 27 Nov 2001 02:43:42 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:22540 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282845AbRK0Hmn>; Tue, 27 Nov 2001 02:42:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Davies <james_m_davies@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
Date: Tue, 27 Nov 2001 17:38:42 +1000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011127074333Z282845-17409+17724@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about implimenting something like KDE's IOSlaves at kernel level? you 
could then create a symlink to any recognized URL. This would also have 
plenty of other uses. 


On Tue, 27 Nov 2001 13:59, Mark Richards wrote:
> Quick question, which I suspect has a long answer.
>
> I would like to write a multiplexing filesystem.  The idea is as follows:
>
> The filesystem would ideally wrap another filesystem, such as nfs or smbfs
> or ext2.  Most operations would just be passed to the native fs call. 
> However, for some files, selectable at run time by some control singal,
> would actually reside on another file system.  The other filesystem would
> have to be mounted.
>
> The idea is for a version controlling filesystem.  The server would be a
> network server (hence the desire to wrap nfs) which presents a 'view' of
> the source code.  When the user reserves a file for editing, the file is
> copied to the local disk.  From that point on, the local file is referred
> to until the user commits the change or unreserves the file.  Ideally, the
> local copy of the file could be on any file system, not one that is
> necessarily local.  And this has to be totally transparent to the user,
> except for the step where the user 'reserves' the file.
>
> I've thought about two ways to do this.  One is to wrap the 'versioning'
> file system with a multiplexor that checks fs calls to see if they are
> referring to a file that is on a different fs.  The other approach is to
> intercept calls to the VFS to do the same trick.
>
> I'm new to the whole filesystem-coding thing, so bear with me if what i've
> just said makes no sense.  So, my question (I guess it wasn't quick after
> all) is: Can it be done, and are either of my two approaches feasible?  Any
> suggestions or tips?
>
> Thanks,
> Mark Richards
>
> PS please CC me if possible.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


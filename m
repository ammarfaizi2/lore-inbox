Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTBJPOK>; Mon, 10 Feb 2003 10:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbTBJPOF>; Mon, 10 Feb 2003 10:14:05 -0500
Received: from unogate.unocal.com ([192.94.3.1]:5118 "EHLO unogate.unocal.com")
	by vger.kernel.org with ESMTP id <S261724AbTBJPNp>;
	Mon, 10 Feb 2003 10:13:45 -0500
Message-ID: <41C61615CE88D211AA3500805F9FFECE05D4B817@renegade.sugarland.unocal.com>
From: "Ogden, Aaron A." <aogden@unocal.com>
To: "'Ian Kent'" <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [autofs] 2.4.20 autofs4 changes
Date: Mon, 10 Feb 2003 07:22:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ian,
I think the 'ghosting' feature is vital to interoperability between Linux
and Solaris systems.  Sun calls this feature 'browsing' and Solaris has had
it for some time.  I don't believe that Irix, AIX and other Unices have this
ability, so it would be a big plus if Linux could do it.  I'm surprised that
this feature hasn't made it into the autofs kernel module yet, it would seem
to be a feature that would be widely used.

I can't speak for anybody else but I would very much like to keep up with
current developments on the autofs list.  (isn't that the point of a mailing
list? :-) )

-A

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net]
Sent: Monday, February 10, 2003 8:43 AM
To: linux-kernel@vger.kernel.org
Cc: autofs@linux.kernel.org
Subject: [autofs] 2.4.20 autofs4 changes



Hi all,

I have written a patch for the autofs4 kernel module (and autofs
4.0.0-pre10 daemon) to deal with ghosting of directories (and to a
limited degree, direct automount maps). Refer to
http://www.themaw.net/includehtml.php?sendit=ians_html/autofs.html for
more information if you wish.

There have been a few changes to the autofs4 module in kernel release
2.4.20 that break this patch. I have looked through the Changelog for
2.4.20 and 2.4.19 and don't see any reference to the changes. I have
also had a brief look through the archives of this list without success.

A first look indicates that the problem for me has been caused by the
removal of the file_operations definition autofs4_dir_operations in
root.c. Then the dcache default file_operations are used for inode
initialization in inode.c instead. My initial impression is that if
there is a specific reason for using the dcache default then I will need
to work on an autofs4 implementation of dcache_dir_lseek. The rest may
be OK.

To save me some time and possible pain I am hoping to find out the
reasoning behind this change from the implementor. Please copy any reply
to my personal email address as I am not subscribed to this list. I
think that the autofs list is closed to people who are not subscribed so
I will forward any replies that don't make it there.

Should notification of these changes be posted to the autofs list?

-- 
Ian Kent <raven@themaw.net>

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

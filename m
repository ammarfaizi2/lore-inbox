Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJAOSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTJAOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:18:14 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:18436 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262188AbTJAOSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:18:07 -0400
Date: Wed, 1 Oct 2003 16:21:25 +0200
From: DervishD <raul@pleyades.net>
To: "Lisa R. Nelson" <lisanels@cableone.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Message-ID: <20031001142125.GA14994@DervishD>
References: <1065012013.4078.2.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Lisa :)

 * Lisa R. Nelson <lisanels@cableone.net> dixit:
> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.

    You're not right here: all Unices I have knowledge about has this
same scheme. But really it doesn't matter, because the reason behind
this is that files are just links in a directory, so for deleting a
file, that is, *unlinking* it, you need to have write permission on
the *container*: the directory.

>     Permissions on a file basis take precedence over directory
> permissions (for most cases), but in Linux they do not.

    Just curiosity: which Unix behaves that way?

> In order to secure a file, you have to secure the directory which
> effects all files within it.

    Not exactly, but you're true. You can use the sticky bit for
directories if you want them to be 'append only'. This way anybody
can read your files if you want, add files and remove them, *but*
they WON'T be able to delete YOUR files. This is used in /tmp, for
example.

>     I verified this on a sun station today

    I may be wrong here, for a long time has passed since I last used
a SparcStation or similar, but AFAIK SunOS behaves like Linux in this
issue. In fact, this is the common Unix behaviour.

> http://www.auburn.edu/oit/software/os/unix_files.html

    Quote: "Permissions are divided into three types [...] Write
permission allows the user [...] For directories, write permission
allows the user to create new files or delete files within that
directory".

> http://www.dartmouth.edu/~rc/help/faq/permissions.html

    The same: "w [...] file is writeable. On a directory, write
access means you can add or delete files".

> http://www.december.com/unix/tutor/permissions.html

    Nothing relevant. A lame tutorial on Unix permissions, BTW.

> http://www.itc.virginia.edu/desktop/web/permissions/

    "Write [...] create a new file in the directory". Incomplete, but
will do...

    As you can see, even your sources say exactly the same...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/

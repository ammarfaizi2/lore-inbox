Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWIQXlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWIQXlz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWIQXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:41:55 -0400
Received: from thunk.org ([69.25.196.29]:8137 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965159AbWIQXly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:41:54 -0400
Date: Sun, 17 Sep 2006 19:41:39 -0400
From: Theodore Tso <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Adam Henley <adamazing@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 8 hours of battery life on thinkpad x60
Message-ID: <20060917234138.GA9049@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
	Adam Henley <adamazing@gmail.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20060917194118.GA3477@elf.ucw.cz> <6bffcb0e0609171307o6a4257e8p560fb809b3535980@mail.gmail.com> <c526a04b0609171357x17144617r3b7c16d030b7aed1@mail.gmail.com> <20060917210059.GB4677@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917210059.GB4677@elf.ucw.cz>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 11:00:59PM +0200, Pavel Machek wrote:
> On Sun 2006-09-17 20:57:40, Adam Henley wrote:
> > >Bug -> http://www.stardust.webpages.pl/files/crap/bug.jpg
> > >
> > 
> > And when I open it, *I* appear as co-author!
> > I never knew... :o)
> 
> Ok, someone fix openoffice :-). I'd even call it a security problem in
> openoffice....

I'm not sure it's a bug.  A mis-designed feature, certainly, combined
with use of said mis-designed feature in the SuSE template.  What
happened is that the template is using the "insert <author> field"
feature.  (Access by Insert->Fields->Author from the menubar).  This
inserts the author, if present, into the text box.  The SuSE template
uses this in the title slide as well as in each slide's master
template.

The problem is that the Author information is copied from each
OpenOffice's user data (set by Tools->Options->Openoffice.org->User data).  
It is **not** a property of the document.  This is the mis-design
feature (although it's documented as working this way, so it's
technically not a bug :-), which makes the feature useless.  So no
sane template or presentation file should use it, since it will look one
way one user's laptop/workstation, but when the presentation is shown
on someone else's system, it won't look the same.  Unfortunately, SuSE's
template uses this mis feature, and then I suspect Pavel has no user 
information set, but since he sees other SuSE information with the author 
information filled out a certain way, he put his name where it would 
"normally" appear manually, and then whoever does has user information
in their Open Office shows up as a co-author.

Recomendations: Tell the Open Office developers that the <author>
information should be saved in the presentation, and only to use the
user-specific openoffice.org information as a default when creating a
documetnation from scratch.  Tell whoever manages the SuSE template to
drop the use of the automatic author feature, as it is dangerous and
doesn't do what people would expect.  All people should check to see
if they are using the automatic embedded Author field, and remove it
from their presentations and replace it with their own name, manually
inserted.

						- Ted

P.S.  The only time I can think of where it might make sense to use
the automatic author information from the user data would be if it is
a marketing slide sales deck, where you want to fill in the name of
the salesperson automatically as if they were the author.  So perhaps
that should be retained as a feature, but there are *so* many other
places where this is not the right answer, so it probably shouldn't be
the default.


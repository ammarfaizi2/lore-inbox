Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWBIPfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWBIPfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWBIPfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:35:52 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:44433 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932531AbWBIPfw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:35:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UoUuC9zCCYZ7K4xyEvelaE/RasIxNM4f/IhjyvOY2bR54vhGFfvVoOsgWtHYItO9MYgM/n9IsY+xjOBD1gI9ebYFmhrPRwMhTmYFvh1FZItxYyb8ydqkFRqklQjzpQHSdI03ifueH4xtuPQE/M3g5zGb/Kqbq/RDf/d2hTdWvbA=
Date: Thu, 9 Feb 2006 16:35:46 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jes@sgi.com, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone?
Message-Id: <20060209163546.493334f8.diegocg@gmail.com>
In-Reply-To: <43EB4F05.8090400@pobox.com>
References: <20060208070301.1162e8c3.pj@sgi.com>
	<yq0vevollx4.fsf@jaguar.mkp.net>
	<43EB4F05.8090400@pobox.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 09 Feb 2006 09:17:41 -0500,
Jeff Garzik <jgarzik@pobox.com> escribió:


> Check out:
> http://linux.yyz.us/git-howto.html

That is a nice guide, but is oriented to developers, I think jes
was asking from a user POV (I've needed to google for such things
several times) ie how to switch to a given tag and return to master,
how to update the repository periodically, etc; no stuff about how to
manage patches. It may be nice to see such thing on your guide, something
like this:


- How to get a copy of linus'tree
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

- Update your copy:
  cd linux-2.6; git pull; git pull --tags

- How to go back to a certain snapshot
  git reset --hard v2.6.13 (ls .git/refs/tags to see all the tags). Not the
  cleanest method, I think. "git-checkout -f master" will return to the "head"
  of the repository. You can also pass commit-IDs to git-reset instead of tags?

- bisect search
  git reset --hard BrokenVersion
  git bisect start
  git bisect good v2.6.13-rc2
  
  Compile, test, and do "git bisect good" or "git bisect bad" until you find
  the culprit. If it doesn't compile or something you can do a "git bisect good/bad"
  "git bisect reset" resets the repository when you are done.
  http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt
  explains it with more detail.

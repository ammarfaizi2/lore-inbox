Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWEUW6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWEUW6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWEUW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:58:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57570 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751486AbWEUW6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:58:22 -0400
Date: Mon, 22 May 2006 00:57:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060521225735.GA9048@elf.ucw.cz>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518103430.080e3523.akpm@osdl.org> <20060519124235.GA32304@MAIL.13thfloor.at> <20060519081334.06ce452d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060519081334.06ce452d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 19-05-06 08:13:34, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > let me
> >  give a simple example here:
> 
> Examples are useful.
> 
> >   "pid virtualization"
> > 
> >   - Linux-VServer doesn't really need that right now.
> >     we are perfectly fine with "pid isolation" here, we
> >     only "virtualize" the init pid to make pstree happy
> > 
> >   - Snapshot/Restart and Migration will require "full"
> >     pid virtualization (that's where Eric and OpenVZ
> >     are heading towards)
> 
> snapshot/restart/migration worry me.  If they require complete
> serialisation of complex kernel data structures then we have a problem,
> because it means that any time anyone changes such a structure they need to
> update (and test) the serialisation.
> 
> This may be a show-stopper, in which case maybe we only need to virtualise
> pid #1.

Well, if pid #1 virtualization is only needed for pstree, we may want
to fix pstree instead :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWBANju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWBANju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWBANju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:39:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38104 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964980AbWBANjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:39:49 -0500
Date: Wed, 1 Feb 2006 08:39:17 -0500
From: Alan Cox <alan@redhat.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jes Sorensen <jes@sgi.com>,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] SGIIOC4 limit request size
Message-ID: <20060201133917.GA27011@devserv.devel.redhat.com>
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com> <20060201104913.GA152005@sgi.com> <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com> <20060201111754.GB152005@sgi.com> <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com> <20060201113607.GF152005@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201113607.GF152005@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 03:36:07AM -0800, Jeremy Higdon wrote:
> Here's one that removes xcount.  It seems to work too.
> Should we set hwif->rqsize to 256, or are we pretty safe in
> expecting that the default won't rise?  The driver should be

255 is the safest for LBA28 devices because a small number incorrectly
interpret 0 (meaning 256) as 0. And that can have unfortunate results

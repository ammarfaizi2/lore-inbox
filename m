Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313821AbSDPSxE>; Tue, 16 Apr 2002 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313823AbSDPSxD>; Tue, 16 Apr 2002 14:53:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26877
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313821AbSDPSxC>; Tue, 16 Apr 2002 14:53:02 -0400
Date: Tue, 16 Apr 2002 11:55:13 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Wichert Akkerman <wichert@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020416185513.GD23513@matchmail.com>
Mail-Followup-To: Wichert Akkerman <wichert@cistron.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel> <p73adsbpdaz.fsf@oldwotan.suse.de> <20020408203515.B540@toy.ucw.cz> <a9gvd1$hsd$1@picard.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:45:53PM +0200, Wichert Akkerman wrote:
> In article <20020408203515.B540@toy.ucw.cz>,
> Pavel Machek  <pavel@suse.cz> wrote:
> >How do you fix errors you find by such background fsck?
> 
> Theoretically I suppose you could use a writeable snapshot and then switch the
> fscked snapshot with the currently mounted fs.
>

Not if there were writes after the fsck.  You could probably do it if there were only
reads though.  If there were writes it would be based on a corrupted (to
whatever extent) filesystem.

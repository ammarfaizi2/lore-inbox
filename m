Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTEFP1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTEFP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:27:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31045 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263812AbTEFP1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:27:17 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
References: <20030504231650.75881288.akpm@digeo.com>
	<1052231590.2166.141.camel@spc9.esa.lanl.gov>
	<20030506083358.348edb4d.akpm@digeo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 09:36:38 -0600
In-Reply-To: <20030506083358.348edb4d.akpm@digeo.com>
Message-ID: <m17k949jeh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > I have one machine for testing which is running X, and a kexec reboot
> >  glitches the video system when initiated from runlevel 5.  Kexec works fine
> >  from runlevel 3.
> 
> Yes, there are a lot of driver issues with kexec.  Device drivers will assume
> that the hardware is in the state which the BIOS left behind.
> 
> In this case, the Linus device driver's shutdown functions are obviously not
> leaving the card in a pristine state.  A lot of drivers _do_ do this
> correctly.  But some don't.
> 
> It seems that kexec is really supposed to be invoked from run level 1.  ie:
> you run all your system's shutdown scripts before switching.  If you'd done
> that then you wouldn't have been running X and all would be well.
> 
> do-kexec.sh is for the very impatient ;)

The biggest issue with kexec when you are in X is that nothing
tells X to shutdown.  So you have to at least shutdown X manually.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTEFQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTEFQ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:27:39 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:30635 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263915AbTEFQZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:25:02 -0400
Subject: Re: 2.5.69-mm1
From: Steven Cole <elenstev@mesatop.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <m17k949jeh.fsf@frodo.biederman.org>
References: <20030504231650.75881288.akpm@digeo.com>
	 <1052231590.2166.141.camel@spc9.esa.lanl.gov>
	 <20030506083358.348edb4d.akpm@digeo.com>
	 <m17k949jeh.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052238949.2166.145.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 06 May 2003 10:35:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 09:36, Eric W. Biederman wrote:
> Andrew Morton <akpm@digeo.com> writes:
> 
> > Steven Cole <elenstev@mesatop.com> wrote:
> > >
> > > I have one machine for testing which is running X, and a kexec reboot
> > >  glitches the video system when initiated from runlevel 5.  Kexec works fine
> > >  from runlevel 3.
> > 
> > Yes, there are a lot of driver issues with kexec.  Device drivers will assume
> > that the hardware is in the state which the BIOS left behind.
> > 
> > In this case, the Linus device driver's shutdown functions are obviously not
> > leaving the card in a pristine state.  A lot of drivers _do_ do this
> > correctly.  But some don't.
> > 
> > It seems that kexec is really supposed to be invoked from run level 1.  ie:
> > you run all your system's shutdown scripts before switching.  If you'd done
> > that then you wouldn't have been running X and all would be well.
> > 
> > do-kexec.sh is for the very impatient ;)
> 
> The biggest issue with kexec when you are in X is that nothing
> tells X to shutdown.  So you have to at least shutdown X manually.
> 
> Eric

Thanks for the answers.  Kexec is pretty cool as it stands.  I hope
Linus merges it soon.

Steven "very impatient" Cole


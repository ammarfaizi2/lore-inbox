Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269432AbUJLD46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269432AbUJLD46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJLD45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:56:57 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:9088 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S269432AbUJLD4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:56:39 -0400
Date: Tue, 12 Oct 2004 06:56:34 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com, joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041012035634.GB665@elektroni.ee.tut.fi>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, roland@redhat.com,
	joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20041010211507.GB3316@triplehelix.org> <200410112055.i9BKt5LI031359@magilla.sf.frob.com> <20041012033934.GA275@elektroni.ee.tut.fi> <20041011205233.5fe4f99f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011205233.5fe4f99f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:52:33PM -0700, Andrew Morton wrote:
> Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
> >
> > On Mon, Oct 11, 2004 at 01:55:05PM -0700, Roland McGrath wrote:
> > > > wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > > 
> > > That is a clearly bogus argument.
> > 
> > Hi. I see it too:
> > 
> > wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > 
> > But the whole problem goes away if I switch CONFIG_REGPARM off. To reproduce
> > it needs CONFIG_REGPARM=y.
> > 
> 
> And what compiler version are you using?
> 

gcc 3.4.2.

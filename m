Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWCGREM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWCGREM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCGREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:04:12 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:11950 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1751213AbWCGREK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:04:10 -0500
From: Dave Peterson <dsp@llnl.gov>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Tue, 7 Mar 2006 09:03:19 -0800
User-Agent: KMail/1.5.3
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       alan@redhat.com, gregkh@kroah.com
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061014.22312.dsp@llnl.gov> <20060306102232.613911f6.rdunlap@xenotime.net>
In-Reply-To: <20060306102232.613911f6.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070903.19226.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 10:22, Randy.Dunlap wrote:
> On Mon, 6 Mar 2006 10:14:22 -0800 Dave Peterson wrote:
> > On Sunday 05 March 2006 02:30, Arjan van de Ven wrote:
> > > On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > > > > +/* Main MC kobject release() function */
> > > > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > > > +{
> > > > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > > > +}
> > > > > +
> > > >
> > > > ehhh how on earth can this be right?
> > >
> > > oh and this stuff also violates the "one value per file" rule; can we
> > > fix that urgently before it becomes part of the ABI in 2.6.16??
> >
> > Ok, I'll admit to being a bit clueless about this.  I'm not familiar
> > with the "one value per file" rule; can someone please explain?
>
> it's in Documentation/filesystems/sysfs.txt
> Strongly preferred.

Ok, I assume the comment refers to the following:

    Attributes should be ASCII text files, preferably with only one value
    per file. It is noted that it may not be efficient to contain only
    value per file, so it is socially acceptable to express an array of
    values of the same type.

I was initially a bit confused because I thought the comment
specifically pertained to the piece of code shown above.  I need to
take a closer look at the EDAC sysfs code - I'm not as familiar with
some of its details as I should be.  Thanks for pointing out the
issue.

Dave

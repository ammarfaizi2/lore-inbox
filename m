Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKLJbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 04:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTKLJbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 04:31:24 -0500
Received: from [202.181.197.10] ([202.181.197.10]:46854 "EHLO
	gandalf.gnupilgrims.org") by vger.kernel.org with ESMTP
	id S261885AbTKLJbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 04:31:23 -0500
Date: Wed, 12 Nov 2003 17:30:20 +0800
To: Willy Tarreau <willy@w.ods.org>
Cc: Kaj-Michael Lang <milang@tal.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112093020.GA8330@gandalf.chinesecodefoo.org>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <20031112061909.GB9634@alpha.home.local> <20031112064942.GA7073@gandalf.chinesecodefoo.org> <20031112091001.GA23762@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112091001.GA23762@alpha.home.local>
User-Agent: Mutt/1.3.28i
From: glee@gnupilgrims.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 10:10:01AM +0100, Willy Tarreau wrote:
> On Wed, Nov 12, 2003 at 02:49:42PM +0800, glee@gnupilgrims.org wrote:
> > On Wed, Nov 12, 2003 at 07:19:09AM +0100, Willy Tarreau wrote:
> > > Hi,
> > > 
> > > for me, -rc1 compiles correctly on Alpha, but I don't use agpgart. So I
> > > guess it's about your only problem here.
> > > 
> > 
> > 
> > I think that we should wrap the msr.h include around a CONFIG_X86_MSR.
> 
> Or simply remove it ? it doesn't seem to me that it's used anywhere in this
> file. Could anybody try this patch ?
> 


Hi Willy,

I think your analysis is correct.  The stuff in msr.h was used back in
2.4.22 for the nvidia stuff, now it's been removed and should 
no longer be required.

	- g.


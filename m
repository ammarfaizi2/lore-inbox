Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbTCZQgO>; Wed, 26 Mar 2003 11:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbTCZQgO>; Wed, 26 Mar 2003 11:36:14 -0500
Received: from ovh.tbs-internet.com ([213.186.35.102]:32919 "EHLO
	www.TBS-satellite.com") by vger.kernel.org with ESMTP
	id <S261767AbTCZQgN>; Wed, 26 Mar 2003 11:36:13 -0500
From: Francis Galiegue <fg6@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
Date: Wed, 26 Mar 2003 17:47:35 +0100
User-Agent: KMail/1.5
References: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com> <20030326163732.GK20098@wohnheim.fh-wedel.de>
In-Reply-To: <20030326163732.GK20098@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200303261747.37313.fg6@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 March 2003 17:37, Jörn Engel wrote:
> On Wed, 26 March 2003 17:27:23 +0100, Martin Schwidefsky wrote:
> > > > + if (sch->lpm == 0)
> > > > +       return -ENODEV;
> > > > + else
> > > > +       return -EACCES;
> > >
> > > I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
> > > just too picky..
> >
> > No, you are not. return (sch->lpm ? -EACCES : -ENODEV) is better.
>
> Are the brackets really necessary? This is highly personal, but I
> spend a few second "stubling" over them, which makes the code less
> readable for me.
>

Hey, after all it's a return we're doing here, no?

if (sch->lpm)
	return -EACCESS;

return -ENODEV;


-- 
Francis Galiegue <fgaliegue@tbs-internet.com>
Vatican (Score:5, Funny) 
by Anonymous Coward on Friday January 24, @11:26AM (#5151284) 
"Scientists at the Vatican Praying Center found that 98% of the prayer queries
at the God level are unnecessary."


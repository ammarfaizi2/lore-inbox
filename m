Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVLIQyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVLIQyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLIQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:54:45 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43483 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932506AbVLIQyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:54:45 -0500
Subject: Re: [patch 3/17] s390: move s390_root_dev_* out of the cio layer.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, cotte@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051209165150.GD23349@stusta.de>
References: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com>
	 <20051209165150.GD23349@stusta.de>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 17:54:43 +0100
Message-Id: <1134147283.5576.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 17:51 +0100, Adrian Bunk wrote:
> On Fri, Dec 09, 2005 at 04:23:45PM +0100, Martin Schwidefsky wrote:
> > +extern struct device *s390_root_dev_register(const char *);
> > +extern void s390_root_dev_unregister(struct device *);
> >...
> 
> If you do _really_ need these wrappers, simply make them
> "static inline"'s in the header file.

We can't. The point here is that we need an external release function
that is still available after the module has been unloaded that uses
these wrappers.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH



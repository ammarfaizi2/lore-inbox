Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUFCLuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUFCLuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbUFCLuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:50:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29673 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264034AbUFCLty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:49:54 -0400
Date: Thu, 3 Jun 2004 07:46:45 -0400
From: Alan Cox <alan@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
Message-ID: <20040603114645.GC5196@devserv.devel.redhat.com>
References: <20040602201315.GA10339@devserv.devel.redhat.com> <20040602231648.57a08478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602231648.57a08478.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:16:48PM -0700, Andrew Morton wrote:
> Alan Cox <alan@redhat.com> wrote:
> >
> > +config VIA_VELOCITY
> >  +	tristate "VIA Velocity support"
> 
> The driver bites the big one when there's no hardware present because it
> still calls register_inetaddr_notifier():

Looks reasonable. The device wants to sleep for wake on lan with its current
address so ->open might work with a little thought.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUAPOxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAPOxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:53:12 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:17937 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265296AbUAPOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:52:57 -0500
Date: Fri, 16 Jan 2004 14:53:11 +0000
From: Joe Thornber <thornber@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Prashanth T <prasht@in.ibm.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
Message-ID: <20040116145311.GD1740@reti>
References: <4007EAE7.2030104@in.ibm.com> <1074261350.4434.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074261350.4434.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:55:50PM +0100, Arjan van de Ven wrote:
> On Fri, 2004-01-16 at 14:45, Prashanth T wrote:
> > Hi,
> >     I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed that
> > this routine to be undefined for UP.  I have attached the patch for 2.6.1
> > below to return 0 for rwlock_is_locked( ) on UP systems.
> > Please let me know.
> 
> I consider any user of this on UP to be broken, just like UP use of
> spin_is_locked() is always a bug..... better a compiletime bug than a
> runtime bug I guess...

Then maybe a #error explaining this is in order ?

- Joe



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUDNHWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbUDNHWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:22:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10983 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264018AbUDNHWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:22:53 -0400
Date: Wed, 14 Apr 2004 08:22:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Fabian Frederick <Fabian.Frederick@skynet.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-ID: <20040414072250.GB31500@parcelfarce.linux.theplanet.co.uk>
References: <1081881778.5585.16.camel@bluerhyme.real3> <20040413170309.14b7a334.akpm@osdl.org> <20040414071102.GB7790@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414071102.GB7790@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 08:11:02AM +0100, Jamie Lokier wrote:
> Andrew Morton wrote:
> > Do races in access() actually matter?  I mean, some other process could
> > change things a nanosecond after access() has completed and the value which
> > the access() caller received is wrong anyway.
> 
> What about the effect access() has on other callers?  It temporarily
> changes current->fsuid, so fs operations in other completely
> independent threads are affected.

Huh?  What does changing a field of tast_struct have to do with behaviour
of some other threads?

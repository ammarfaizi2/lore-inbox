Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUFCVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUFCVGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUFCVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:06:50 -0400
Received: from thunk.org ([140.239.227.29]:44781 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264295AbUFCVGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:06:49 -0400
Date: Thu, 3 Jun 2004 17:06:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com, vojtech@suse.cz
Subject: Re: [RFC] Changing SysRq - show registers handling
Message-ID: <20040603210601.GC6709@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Oliver Neukum <oliver@neukum.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	greg@kroah.com, vojtech@suse.cz
References: <200406030134.04121.dtor_core@ameritech.net> <20040603001804.750b7fa5.akpm@osdl.org> <200406030227.22178.dtor_core@ameritech.net> <200406030944.01615.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406030944.01615.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 09:44:01AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 3. Juni 2004 09:27 schrieb Dmitry Torokhov:
> > I don't like the requirement of SysRq request processing being in hard
> > interrupt handler - that excludes uinput-generated events and precludes
> > moving keyboard handling to a tasklet for example.
> 
> SysRq should work even if bottom halfs don't.

Indeed; one of the times when SysRq-p is used in the field is when the
machine is completely wedged.  Sometimes it's the only way to figure
out where the machine is wedged.  It would be unfortunate if the
number of cases (when the kernel is four feet in the air and
twitching) where SysRq worked decreases as a result of the proposed
change.

						- Ted

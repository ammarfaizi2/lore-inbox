Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTIDUse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbTIDUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:48:34 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64396 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262105AbTIDUsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:48:33 -0400
Date: Thu, 4 Sep 2003 21:48:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Heath <chris@heathens.co.nz>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, vojtech@ucw.cz,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030904204816.GD31590@mail.jlokier.co.uk>
References: <20030903235647.C765.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903235647.C765.CHRIS@heathens.co.nz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Heath wrote:
> 1. I assume it is OK to defer processing the code e0 until the following
> byte arrives.  Are there any keyboards out there with e0 in the keyboard
> ID?  This could break the atkbd probe for such keyboards.  (The
> alternative would be to pass the repeated key releases through to atkbd,
> and let that layer remove the duplicates.)
> 
> 2. The event that appears between two repeated key releases is always a
> key release and not a key press.
> 
> 3. There will only be at most one key event in between two repeated key 
> releases.

Why so many complicated assumptions?  Just maintain a bitmap if key
up/down states (initialised to up), and if you receive a release event
when the key is in the up state, ignore the event.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUAUKF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 05:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUAUKF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 05:05:26 -0500
Received: from smtp08.auna.com ([62.81.186.18]:13307 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S262446AbUAUKFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 05:05:19 -0500
Date: Wed, 21 Jan 2004 11:05:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, mort@bork.org,
       viro@parcelfarce.linux.theplanet.co.uk, bluefoxicy@linux.net
Subject: Re: struct task_struct -> task_t
Message-ID: <20040121100517.GA15918@werewolf.able.es>
References: <1074642648.828.40311.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1074642648.828.40311.camel@cube> (from albert@users.sf.net on Wed, Jan 21, 2004 at 00:50:48 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.21, Albert Cahalan wrote:
> Martin Hicks writes:
> > On Mon, Jan 19, 2004 at 10:24:34PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> >> On Mon, Jan 19, 2004 at 02:17:57PM -0800, john moser wrote:
> 
> >>> It has come to my attention that in some places
> >>> in the kernel, 'struct task_struct' is used; and
> >>> in others, 'task_t' is used.  Also, 'task_t' is
> >>> 'typedef struct task_struct task_t;'.
> >>>
> >>> I made a small script to change around as much
> >>> as I could so that everything uses task_t,
> >>
> >> What the fsck for?  If anything, the opposite
> >> (and removal of that typedef) would be preferable.
> >
> > John,
> >
> > As Al is trying to point out, we try to discourage
> > the use of typedefs in the kernel.  It is much
> > easier to see that blah_t is really a struct if
> > we always use 'struct blah'.
> 
> That's no good for variable usage. We don't
> write "struct current".
> 
> You're giving the argument for Hungarian
> notation. Not that I'd suggest it, but that
> is where your argument leads.
> 
> IMHO, we type too much already.
> 

At least, don't be redundant.
If you want explicit struct, let the type be 'struct task'
(ie, kill the second _struct).
If you want to use struct types as the rest of types, typedef
a task_t.
But 'struct task_struct' is redundand, long and ugly.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-jam4 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))

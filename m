Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbTCYLbj>; Tue, 25 Mar 2003 06:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTCYLbj>; Tue, 25 Mar 2003 06:31:39 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:22535 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262132AbTCYLan>; Tue, 25 Mar 2003 06:30:43 -0500
Date: Tue, 25 Mar 2003 11:41:52 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Module load notification take 3
Message-ID: <20030325114152.GB30581@compsoc.man.ac.uk>
References: <20030325020316.GA95492@compsoc.man.ac.uk> <20030325063320.843BD2C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325063320.843BD2C04C@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18xmoT-000GTr-00*YXpNTc/ogX.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 05:32:33PM +1100, Rusty Russell wrote:

> > Implement a module load notifier for the benefit of OProfile, tested
> > with .66 on UP.
> 
> Minor change to make unregister_module_notifier return void.

The -ENOENT return is there for a reason. If you don't want it, then you
should remove it from notifier_call_register too.

john

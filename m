Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTAZCWc>; Sat, 25 Jan 2003 21:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbTAZCWc>; Sat, 25 Jan 2003 21:22:32 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53446 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265936AbTAZCWb>; Sat, 25 Jan 2003 21:22:31 -0500
Date: Sat, 25 Jan 2003 20:31:27 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] [PATCH] new modversions implementation
In-Reply-To: <20030125225613.GA9429@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301252030530.6749-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Sam Ravnborg wrote:

> On Sat, Jan 25, 2003 at 10:56:37PM +0100, Sam Ravnborg wrote:
> > +
> > +# Don't rebuilt vermagic.o unless we actually are in the init/ dir
> > +ifneq ($(obj),init)
> > +init/vermagic.o: ;
> > +endif
> > 
> > The above magic does not look safe to me when utilising parrallel builds.
> > At least init/vermagic.o needs to be in the prepare: rule.
> 
> Checked, it is in the prepare: rule, but it looks ugly anyway.
> Does it really need to be a prerequisite?

Yes, because we need to rebuild the module when vermagic.o changed, 
otherwise we'd end up with stale information in modules.

--Kai



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTAYWrL>; Sat, 25 Jan 2003 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTAYWrL>; Sat, 25 Jan 2003 17:47:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28432 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262602AbTAYWrK>;
	Sat, 25 Jan 2003 17:47:10 -0500
Date: Sat, 25 Jan 2003 23:56:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] [PATCH] new modversions implementation
Message-ID: <20030125225613.GA9429@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu> <20030125215637.GA3571@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125215637.GA3571@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 10:56:37PM +0100, Sam Ravnborg wrote:
> +
> +# Don't rebuilt vermagic.o unless we actually are in the init/ dir
> +ifneq ($(obj),init)
> +init/vermagic.o: ;
> +endif
> 
> The above magic does not look safe to me when utilising parrallel builds.
> At least init/vermagic.o needs to be in the prepare: rule.

Checked, it is in the prepare: rule, but it looks ugly anyway.
Does it really need to be a prerequisite?

	Sam

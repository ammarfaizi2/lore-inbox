Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSIJSgE>; Tue, 10 Sep 2002 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSIJSgD>; Tue, 10 Sep 2002 14:36:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:10500 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317946AbSIJSgC>;
	Tue, 10 Sep 2002 14:36:02 -0400
Date: Tue, 10 Sep 2002 20:40:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] 1/8 LTT for 2.5.34: Core infrastructure
Message-ID: <20020910204041.A2197@mars.ravnborg.org>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <3D7E36E2.625141D6@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D7E36E2.625141D6@opersys.com>; from karim@opersys.com on Tue, Sep 10, 2002 at 02:16:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 02:16:02PM -0400, Karim Yaghmour wrote:
> +ifdef CONFIG_TRACE
> +obj-y += trace.o
>  endif
This is still bogus.
The day that CONFIG_TRACE equals n you will still include trace.o.
An explicit test for m or y is preferable.

On the other hand there is a lot of places in the makefiles that gets this
wrong - sigh.

	Sam

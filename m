Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSBRS3R>; Mon, 18 Feb 2002 13:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSBRSXj>; Mon, 18 Feb 2002 13:23:39 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:33287 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S290503AbSBRSVn>;
	Mon, 18 Feb 2002 13:21:43 -0500
Date: Mon, 18 Feb 2002 18:21:40 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: khubd zombie
Message-ID: <20020218182140.GA62585@compsoc.man.ac.uk>
In-Reply-To: <1014039193.523.42.camel@dev1lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014039193.523.42.camel@dev1lap>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 02:33:13PM +0100, Patrik Weiskircher wrote:

> killall khubd results to:
> 10 ?        Z      0:00 [khubd <defunct>]
> 
> is this ok?
> if not, how can i solve this?

add reparent_to_init() in drivers/usb/hub.c (by the daemonize()).

I imagine the fix is sitting in some USB changes somewhere ...

john

-- 
"They eat cold meat for breakfast and make jokes about gzip."
	- Rik Hemsley on KDE developers

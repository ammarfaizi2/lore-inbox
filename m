Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272471AbTGaNDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272473AbTGaNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:03:43 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:64444 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S272471AbTGaNDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:03:41 -0400
Date: Thu, 31 Jul 2003 15:03:38 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fun or real: proc interface for module handling?
Message-ID: <20030731130338.GB23570@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030731121248.GQ264@schottelius.org> <yw1xptjqub7q.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xptjqub7q.fsf@users.sourceforge.net>
X-Operating-System: vega Linux 2.6.0-test2 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:34:01PM +0200, M?ns Rullg?rd wrote:
> > Modul options could be passed my
> >    echo "psmouse_noext=1" > /proc/mods/psmouse/options
> > which would also make it possible to change module options while running..
> 
> How would options be passed when loading?  Some modules require that
> to load properly.  Also, there are lots of options that can't be
> changed after loading.  To enable this, I believe the whole option
> handling would need to be modified substantially.  Instead of just
> storing the values in static variables, there would have to be some
> means of telling the module that its options changed.  Then there's
> the task of hacking all modules to support this...

Interesting :)

Maybe, it should cause no action to "mkdir /proc/mods/ipv6", nor echo
"psmouse_noext=1" > /proc/mods/psmouse/options
_just_ "collecting" parameters by kernel, then eg creating a file
/proc/mods/ipv6/load should cause to load the module. Of course there can be
code to handle "on-the-fly" parameter change, but maybe this can be
considered as optimal, and it should be not a must a module to support this
...

- Gábor (larta'H)

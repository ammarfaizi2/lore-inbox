Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132444AbQK0CTK>; Sun, 26 Nov 2000 21:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135291AbQK0CTA>; Sun, 26 Nov 2000 21:19:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:58640 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S132444AbQK0CSy>; Sun, 26 Nov 2000 21:18:54 -0500
Date: Sun, 26 Nov 2000 19:45:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules?
Message-ID: <20001126194543.D2265@vger.timpanogas.org>
In-Reply-To: <20001126170135.A1787@vger.timpanogas.org> <1887.975282334@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1887.975282334@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Nov 27, 2000 at 10:45:34AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:45:34AM +1100, Keith Owens wrote:
> On Sun, 26 Nov 2000 17:01:35 -0700, 
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
> >insmod ppp_deflate (should trigger load of all these modules).  I 
> >know it's works this way if there's a modules.dep file laying 
> >around, but it would be nice for it to work this way without 
> >needing the external text file.
> 
> There is a clean split between modprobe and insmod, modprobe is the
> high level command that does all the fancy checking for inter module
> dependencies, handling aliases and extracting options from
> modules.conf.  insmod is the low level command that does exactly what
> you tell it to do, no more, no less.  The only smarts that insmod has
> is the ability to take a module name without '/' and find it using the
> patchs in modules.conf.  That split between high and low level commands
> is too useful to contaminate.
> 
> modules.conf already supports "above" and "below" commands for
> non-standard dependencies.  The problem of not having a module.dep on
> the first boot of a new kernel was addressed in kernel 2.4.0-test5 or
> thereabouts, make modules_install runs depmod to build modules.dep
> ready for the first boot.


Good.  I am glad this is being addressed.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

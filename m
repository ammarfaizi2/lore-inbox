Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272968AbTGaMjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273006AbTGaMjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:39:23 -0400
Received: from main.gmane.org ([80.91.224.249]:53467 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272968AbTGaMjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:39:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: fun or real: proc interface for module handling?
Date: Thu, 31 Jul 2003 14:34:01 +0200
Message-ID: <yw1xptjqub7q.fsf@users.sourceforge.net>
References: <20030731121248.GQ264@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:lpCP3CeLN2K5dZN9WHlwO0BfaRo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> writes:

> I was just joking around here, but what do you think about this idea:
>
> A proc interface for module handling:
>    /proc/mods/
>    /proc/mods/<module-name>/<link-to-the-modules-use-us>
>
> So we could try to load a module with
>    mkdir /proc/mods/ipv6
> and remove it and every module which uses us with
>    rm -r /proc/mods/ipv6

So far, so good.

> Modul options could be passed my
>    echo "psmouse_noext=1" > /proc/mods/psmouse/options
> which would also make it possible to change module options while running..

How would options be passed when loading?  Some modules require that
to load properly.  Also, there are lots of options that can't be
changed after loading.  To enable this, I believe the whole option
handling would need to be modified substantially.  Instead of just
storing the values in static variables, there would have to be some
means of telling the module that its options changed.  Then there's
the task of hacking all modules to support this...

-- 
Måns Rullgård
mru@users.sf.net


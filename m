Return-Path: <linux-kernel-owner+w=401wt.eu-S1751559AbXAUNMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXAUNMF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbXAUNME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:12:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4583 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751545AbXAUNMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:12:02 -0500
Date: Fri, 19 Jan 2007 10:11:04 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alessandro Di Marco <dmr@gmx.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
Message-ID: <20070119101103.GA5730@ucw.cz>
References: <877ivkrv5s.fsf@gmx.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ivkrv5s.fsf@gmx.it>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HiQ

> this is a new 2.6.20 module implementing a user inactivity trigger. Basically
> it acts as an event sniffer, issuing an ACPI event when no user activity is
> detected for more than a certain amount of time. This event can be successively
> grabbed and managed by an user-level daemon such as acpid, blanking the screen,
> dimming the lcd-panel light ? la mac, etc...

While functionality is extremely interesting.... does it really have
to be in kernel?


> +if [ ! -d "/proc/sin" ]; then
> +    echo "/proc/sin not found, has sinmod been loaded?"
> +    exit
> +fi

No new /proc files, please.

> +cat <<EOF
> +
> +SIN wakes up periodically and checks for user activity occurred in the
> +meantime; this options lets you to specify how much frequently SIN should be
> +woken-up. Its value is expressed in tenth of seconds.

Heh. We'll waste power trying to save it. If you have to hook it into
kernel, can you at least do it properly?

						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

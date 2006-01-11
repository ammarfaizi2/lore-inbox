Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWAKWkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWAKWkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAKWkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:40:45 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:7304 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932412AbWAKWkn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:40:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f/lFJPs2ZcA9V+WNDP51/lIA14I7Aw9WzzSTrMD1+x38CXrUt9U1MXhyM4IXq5R8mAYokzQmhKbTyWrWDYKLHIFsXQr7wQ0pJX86DB90kkOx+Xh4JYgJMW1OYq2iNx9NA1U6HoOQ+BFHK3KkEM6+wo+NRZgAqjgJ+cO6Mkh1ww0=
Message-ID: <9a8748490601111440m53fdab80pfefc10efb214f3bd@mail.gmail.com>
Date: Wed, 11 Jan 2006 23:40:42 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: load average wraps at 1024
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Don't know if this is a kernel issue or userspace issue, but load
average values wrap back to 0 once they hit 1024.

I've been trying to stress 2.6.15-mm3 by putting a *lot* of load on it
and seeing if it stays alive, how it copes, how long it seems to take
to recover etc.
While doing that I've done some test runs that start thousands of
processes and the load average quickly shoots up to several hundred
and eventually reach 1000 - when it continues to climb it goes to 1023
and then wraps down to small numbers like 4-5 and then continue
climbing from there. Once I kill all my processes it slowly goes down
to zero, then wraps back to ~1000 and continues to climb down from
there until it's eventually back to normal.

Is this expected behaviour?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

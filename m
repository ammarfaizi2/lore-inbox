Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQKMX36>; Mon, 13 Nov 2000 18:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbQKMX3s>; Mon, 13 Nov 2000 18:29:48 -0500
Received: from maile.telia.com ([194.22.190.16]:7954 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S129478AbQKMX3d>;
	Mon, 13 Nov 2000 18:29:33 -0500
From: Roger Larsson <roger@norran.net>
Date: Mon, 13 Nov 2000 23:58:00 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org> <20001112233144.L4824@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001112233144.L4824@arthur.ubicom.tudelft.nl>
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
MIME-Version: 1.0
Message-Id: <00111323580000.01856@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 November 2000 23:31, Erik Mouw wrote:
> On Sun, Nov 12, 2000 at 02:39:09PM -0500, tytso@mit.edu wrote:
> >      * USB: system hang with USB audio driver {CRITICAL} (David
> >        Woodhouse, Randy Dunlap, Narayan Desai) (Fixed with usb-uhci;
> >        uhci-alt is unknown -- randy dunlap)
>
> I can still hang the system with XMMS (1.0.1) using real-time priority.
> The system doesn't die, but it is completely unresponsive. There is no
> sound, but after the MP3 file is played, the system works again. I can
> reproduce this behaviour with usb-uhci and uhci-alt on 2.4.0-test10.
> I haven't test test11-pre3 yet, but the changes don't look too big that
> the "bug" has been fixed.
>

Does it use non blocking IO?
In such case you might have created an infinite loop at high priority
resulting in a busylock of all other processes.


> BTW, I don't think this is a critical bug.
>
>
> Erik

-- 
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

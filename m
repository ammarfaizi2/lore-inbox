Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTG0Ots (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbTG0Ots
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:49:48 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48538
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270808AbTG0Otq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:49:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [PATCH] O9int for interactivity
Date: Mon, 28 Jul 2003 01:09:13 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <YWZVOVR72A8A5FQN7586LHRMFDLIW.3f23e901@monpc>
In-Reply-To: <YWZVOVR72A8A5FQN7586LHRMFDLIW.3f23e901@monpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307280109.13872.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 01:00, Guillaume Chazarain wrote:
> 27/07/03 03:57:19, Con Kolivas <kernel@kolivas.org> wrote:
> >On Sun, 27 Jul 2003 07:20, Guillaume Chazarain wrote:
> >> Hi Con,
> >>
> >> Strange your activate() function in O9. Isn't it?
> >> It doesn't care that much about sleep_time.
> >>
> >> So here is a very simple trouble maker.
> >
> >Yes I know it's a way to make something fairly cpu intensive remain
> >interactive. However since it sleeps long enough (2ms at 1000Hz is just
> >enough), it doesn't bring the machine to a standstill, and is easily
> >killable. I doubt it is worth working around this, but I'm open to your
> >comments about variations on this theme that might be a problem.
>
> The previous code was a mistake. (Calling clock() before sleeping is quite
> dumb...) Here is another one.  If you put the right value in MHZ, (maybe
> more, maybe less, I dunno), I bet you won't get out without power cycling
> your box...

Well I tried it. Luckily it was on an O10 int patched kernel which has some 
extra safeguards and it made the machine jerky but usable and easy to kill 
the troublemaker. Check for O10int which I'm posting soon, and see if what 
I've done is adequate.

Con


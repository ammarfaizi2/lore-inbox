Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTKBUhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTKBUhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:37:13 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:39692 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261825AbTKBUhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:37:10 -0500
Date: Sun, 2 Nov 2003 21:37:01 +0100
From: DervishD <raul@pleyades.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/input/mice doesn't work in test9?
Message-ID: <20031102203700.GA54@DervishD>
References: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru> <200311021312.15902.arvidjaar@mail.ru> <20031102120820.GC206@DervishD> <200311022045.41928.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200311022045.41928.arvidjaar@mail.ru>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andrey :)

 * Andrey Borzenkov <arvidjaar@mail.ru> dixit:
> >     But not char-major-13-32, for example.
> for kernel device == major. It is assumed that complete major is
> handled by single driver.

    OK, now all makes sense :)

> But again, mousedev is using range of minors and 
> there is currently no established way to construct aliases for that. Short of 
> defining
> 
> alias char-major-13-32 mousedev
> alias char-major-13-33 mousedev
> ...
> alias char-major-13-63 mousedev
> 
> looks rather weird.

    But, is it possible? Just guessing...
 
> >     Yes, I'm going to build in hid, but, should I do the same with
> > mousedev (or event, joystick, etc...) or will it work with hid loaded
> > when doing 'cat /dev/mouse'?
> yes you should build it in. Or ensure it is loaded together with hid. 

    It's easier if I just build it in. No need to mess with
modules.conf for this one. The memory gain for having hid and
mousedev as modules is minimal.

    Thanks for all the explanations :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/

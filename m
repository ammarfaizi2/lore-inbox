Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSHWH3x>; Fri, 23 Aug 2002 03:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSHWH3x>; Fri, 23 Aug 2002 03:29:53 -0400
Received: from serv-217-188.SerNet.DE ([193.159.217.188]:40197 "EHLO
	mail.emlix.com") by vger.kernel.org with ESMTP id <S318546AbSHWH3w>;
	Fri, 23 Aug 2002 03:29:52 -0400
Date: Fri, 23 Aug 2002 09:38:12 +0200
From: Oskar Schirmer <os@emlix.com>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
References: <200208210932.36132.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200208210932.36132.h.schurig@mn-logistik.de>
User-Agent: Mutt/1.3.22.1i
Organization: emlix GmbH
Message-Id: <E17i91I-0007nB-00@mailer.emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 09:32:36AM +0200, Holger Schurig wrote:
> 1 pause -> send keycode for character "a"
> 1 1 pause -> send keycode for character "b"
> 1 1 1 pause -> send keycode for character "c"
> 2 pause -> send keycode for character "d"

IMO this should not be done by the kernel, but by the application.

Reasons:
- actually, there is no key "a" etc that is pressed, but "1" etc.
- you loose ability to keep the display up to date according
  to the pressed key sequence while composing characters, otherwise.
- it is easy for the application to check the timing of the
  keys pressed and produce the desired characters instead [poll (2)].
- not all projects using the keyboard in question will need the
  sequence-to-character conversion You describe. e.g. cash register.

gruesse(oskar)
-- 
oskar schirmer, emlix gmbh, http://www.emlix.com, mailto:os@emlix.com
fon +49 551 37000-37, fax -38, friedländer weg 7, 37085 göttingen, germany

emlix - your embedded linux partner

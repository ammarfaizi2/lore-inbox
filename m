Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263658AbRFASOP>; Fri, 1 Jun 2001 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263659AbRFASOF>; Fri, 1 Jun 2001 14:14:05 -0400
Received: from comverse-in.com ([38.150.222.2]:42203 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S263658AbRFASNx>; Fri, 1 Jun 2001 14:13:53 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F0F@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Dawson Engler'" <engler@csl.Stanford.EDU>, kai@tp1.ruhr-uni-bochum.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
Date: Fri, 1 Jun 2001 14:09:34 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you do implement such a thing, make sure that you don't mistakenly spot
smth that gets exported to a non-kernel-tree driver, or smth that gets
called by a non-__init, --- but not in the current kernel config!

V.

> -----Original Message-----
> From: Dawson Engler [mailto:engler@csl.Stanford.EDU]
> checker to
> > find functions which are only called from __init functions, but not
> > marked __init themselves, you'd most likely find lots more 
> performance
> > bugs of this kind.
> 
> I haven't hacked this in --- I was waiting to get a feel for how
> important the checker was before spending too much time on 

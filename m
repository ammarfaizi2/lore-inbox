Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbRF1Vfo>; Thu, 28 Jun 2001 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRF1Vfe>; Thu, 28 Jun 2001 17:35:34 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:30480 "HELO
	juggernaut.dmz.guardiandigital.com") by vger.kernel.org with SMTP
	id <S264476AbRF1VfT>; Thu, 28 Jun 2001 17:35:19 -0400
Date: Thu, 28 Jun 2001 17:35:14 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: Justin Guyett <justin@soze.net>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, james bond <difda@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: BIG PROBLEM
In-Reply-To: <Pine.LNX.4.33.0106281413080.23200-100000@gw.soze.net>
Message-ID: <Pine.LNX.4.10.10106281734140.11669-100000@mastermind.inside.guardiandigital.com>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Justin Guyett wrote:

> On Thu, 28 Jun 2001, Ralf Baechle wrote:
> 
> > Some versions of the 3c59x driver emit a NUL character on bootup which makes
> > klogd suck CPU.  This is fixed in 2.4.5, dunno about 2.4.4.
> 
> sysklogd 1.4.1 changelog lists a no busyloop fix.

Check out:  http://bugs.debian.org/85478

  "When klogd's LogLine() function encounters a null byte in state
   PARSING_TEXT, it will loop infinitely.  More precisely, copyin()
   will treat the null byte as a delimiter - unlike LogLine(), which
   will invoke copyin() ever and ever again."

Kinda off-topic, but I just wanted to prove that the bug was in klogd and
not the kernel. :)

-r


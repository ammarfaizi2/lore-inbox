Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJZKdS>; Sat, 26 Oct 2002 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJZKcy>; Sat, 26 Oct 2002 06:32:54 -0400
Received: from users.linvision.com ([62.58.92.114]:57236 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262089AbSJZKbu>; Sat, 26 Oct 2002 06:31:50 -0400
Date: Sat, 26 Oct 2002 12:38:01 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Stephen Satchell <list@fluent2.pyramid.net>, hps@intermeta.de,
       linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021026123801.C16359@bitwizard.nl>
References: <Pine.LNX.3.95.1021023105535.13301A-100000@chaos.analogic.com> <Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net> <5.1.0.14.0.20021024210320.01db0750@fluent2.pyramid.net> <20021025134723.GZ15886@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025134723.GZ15886@ns>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 09:47:23AM -0400, Stephen Frost wrote:
> Eh, it depends on how you look at it, but...  The cisco includes support
> for checking out high-level protocols, such as HTTP.  Basically you can

So, your PIX is looking at the HTTP requests, and it is validating
them. Fine. Now what is the largest HTTP request that you're going
to allow? 1k? 10k? 100k? 

The PIX is NOT filtering the size of the HTTP request. It will happily
allow a multimegabyte request to come through. Is that exploiting a bug
in your http server? You don't know. And the PIX doesn't help. 

When I encountered a PIX, multimegabyte HTTP requests were valid, and
the PIX screwed them up. A slight thinko on the side of the PIX 
programmers. 

The PIX HTTP filtering may give you some extra controls (I hear you can
do URL based filtering.... Wow!). Don't you have that control on your 
webserver?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUFUI2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUFUI2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUFUI2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:28:08 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:14720 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266173AbUFUI1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:27:53 -0400
Date: Mon, 21 Jun 2004 10:28:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Langley <nwo@hacked.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with psmouse detecting generic ImExPS/2
Message-ID: <20040621082831.GC1200@ucw.cz>
References: <20040621021651.4667bf43.nwo@hacked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621021651.4667bf43.nwo@hacked.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 02:16:51AM -0500, Michael Langley wrote:
> I noticed this after upgrading 2.6.6->2.6.7
> 
> Even after building psmouse as a module, and specifying the protocol,
> all I get is an ImPS/2 Generic Wheel Mouse.
> 
> [root@purgatory root]# modprobe psmouse proto=exps
> Jun 21 01:51:57 purgatory kernel: input: ImPS/2 Generic Wheel Mouse on
> isa0060/serio1
> 
> My ImExPS/2 was detected correctly in <=2.6.6 and after examining the
> current psmouse code, and the changes in patch-2.6.7, I can't figure out
> what's breaking it.  A little help?
 
Maybe your mouse needs the ImPS/2 init before the ExPS/2 one. You can
try to copy and-paste the ImPS/2 init once more in the code, without a
return, of course.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

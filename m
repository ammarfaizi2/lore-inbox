Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbUDNJyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUDNJyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:54:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26290
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264017AbUDNJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:54:32 -0400
Date: Wed, 14 Apr 2004 11:54:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
Subject: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!
Message-ID: <20040414095435.GH2150@dualathlon.random>
References: <200404141257.16731.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404141257.16731.gluk@php4.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 12:57:16PM +0400, Alexander Y. Fomichev wrote:
> G'Day,
> 
> I've got a bug on 2.6.5-aa3 today
> 
> System: Dual P4 Xeon 2.4GHz, 4G ECC RAM - (production web-server) pretty
> 	heavy loaded at most time, but i've got it approximately 
> 	at 02:00 (MSD) when no serious load should be.
> 	System remained accessible all the time but operations
> 	with proclist from userspace (i.e. ps, w) appears to be locked. 

I don't think apache2 uses nonlinear. there was an smp race fix in
2.6.5-aa4, so you may want to try again with 2.6.5-aa5 (latest) just in
case this was mm corruption triggered by the race.

Are you using threading with apache2? Such a race could trigger only
with threads.

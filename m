Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTEVAru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTEVAru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:47:50 -0400
Received: from imladris.surriel.com ([66.92.77.98]:45967 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262416AbTEVArt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:47:49 -0400
Date: Wed, 21 May 2003 21:00:46 -0400 (EDT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Robert White <rwhite@casabyte.com>
cc: David Woodhouse <dwmw2@infradead.org>, "" <ptb@it.uc3m.es>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGEENCMAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.50L.0305212059500.6321-100000@imladris.surriel.com>
References: <PEEPIDHAKMCGHDBJLHKGGEENCMAA.rwhite@casabyte.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Robert White wrote:

> In point of fact, "proper" locking, when combined with "proper"
> definitions of an interface dictate that recursive locking is "better".
> Demanding that a call_EE_ know what locks a call_ER_ (and all
> antecedents of caller) will have taken is not exactly good design.

So call_EE_ messes with the data structure which call_ER_
has locked, unexpectedly because the recursive locking
doesn't show up as an error.

Looks like recursive locking would just make debugging
harder.

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/

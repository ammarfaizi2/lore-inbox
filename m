Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTHOQlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267952AbTHOQfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:35:06 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:36293
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270022AbTHOQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:33:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Sat, 16 Aug 2003 02:40:07 +1000
User-Agent: KMail/1.5.3
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308141746.53346.kernel@kolivas.org> <3F3BEB0C.9090608@techsource.com>
In-Reply-To: <3F3BEB0C.9090608@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160240.07605.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 06:03, Timothy Miller wrote:
> Con Kolivas wrote:
> > Thus tasks that never sleep are always below the interactive delta
> > so each time they use up their timeslice they go onto the expired array.
> > Tasks with enough bonus points can go back onto the active array if they
> > haven't used up those bonus points.
>
> How does a bonus point translate to a priority level?  How many bonus
> points can you collect?

That depends entirely on the algorithm used, and that's where my patches 
differ from the main kernel tree. In the main kernel tree, you need to 
accumulate about one second worth of sleep before being elevated one priority 
(woefully long), and use up one second before dropping. Mine is non linear so 
it's not a simple relationship.

Con


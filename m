Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTFYTUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTFYTUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:20:47 -0400
Received: from relay.pair.com ([209.68.1.20]:62992 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264952AbTFYTUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:20:46 -0400
X-pair-Authenticated: 65.247.36.27
Subject: Re: patch O1int for 2.5.73 - interactivity work
From: Daniel Gryniewicz <dang@fprintf.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net>
References: <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056569692.1594.30.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 25 Jun 2003 15:34:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 15:00, Mike Galbraith wrote:
> At 02:09 AM 6/26/2003 +1000, Con Kolivas wrote:
> 
> >I'm still working on something for the "xmms stalls if started during very
> >heavy load" as a different corner case.
> 
<snip scheduler suggestion>
> Just a couple random thoughts, both of which I can see problems with ;-)
> 

At least on 2.4 (I use 21-ck3), it appears to be I/O starvation that
gets xmms, not scheduler starvation.  When xmms skips for me, there's
load, but there's also usually some idle time.  The common thread seems
to be heavy I/O on the drive xmms is using, possibly combined with a
(formerly?) interactive process (evolution rebuilding my LKML index, for
example) doing the disk I/O.  Because of the assorted I/O scheduler
changes in 2.5, this is unlikley to be the problem there.

Daniel
-- 
Daniel Gryniewicz <dang@fprintf.net>


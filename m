Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUGHQEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUGHQEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGHQEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:04:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19915 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264358AbUGHQDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:03:53 -0400
Date: Thu, 8 Jul 2004 11:03:37 -0500
From: linas@austin.ibm.com
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040708110337.N21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040706084116.11ab7988.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040706084116.11ab7988.moilanen@austin.ibm.com>; from moilanen@austin.ibm.com on Tue, Jul 06, 2004 at 08:41:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 08:41:16AM -0500, Jake Moilanen wrote:
> 
> > > Firmware can report errors at any time, and not atypically during boot.
> > > However, these reports were being discarded until th rtasd comes up,
> > > which occurs fairly late in the boot cycle.  As a result, firmware
> > > errors during boot were being silently ignored.
> 
> Linas, the main consumer of error-log is events coming in from
> event-scan.  We don't call event-scan until rtasd is up (eg they are
> queued in FW until we call event-scan).  

Actually, they don't seem to be queueed at all; when I turned on 
logging earlier, a whole pile of messages poped out that weren't 
visible before.

> The only events I see us
> missing are epow events, 

Depends on what you are doing.  In my case, the fact that the 
early-boot messages were discarded was hiding a bug (that was causing
those messages, that I've sent in a patch for).

--linas

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284643AbRLIXR7>; Sun, 9 Dec 2001 18:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284639AbRLIXRu>; Sun, 9 Dec 2001 18:17:50 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:14699 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284638AbRLIXQp>; Sun, 9 Dec 2001 18:16:45 -0500
Date: Sun, 9 Dec 2001 18:16:43 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make highly niced processes run only when idle
Message-ID: <20011209181643.A8846@redhat.com>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org> <1007939114.878.1.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1007939114.878.1.camel@phantasy>; from rml@tech9.net on Sun, Dec 09, 2001 at 06:05:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 06:05:13PM -0500, Robert Love wrote:
> the boost...  Or, we could fix in-kernel deadlocks by doing priority
> inheriting on locks held by A and wanted by B (i.e., if A holds
> something B wants, boost A's priority temporarily to that of B's).  But
> that is probably overkill ... note to do any of these it is probably
> cleanest to make a SCHED_IDLE scheduling class.

Even better would be to keep the process at low priority while in userland 
and reverts to normal "nice" priority while in kernelspace.

		-ben

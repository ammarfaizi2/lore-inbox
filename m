Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbRLIXrV>; Sun, 9 Dec 2001 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLIXrL>; Sun, 9 Dec 2001 18:47:11 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:58481 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284688AbRLIXq5>; Sun, 9 Dec 2001 18:46:57 -0500
Date: Sun, 9 Dec 2001 18:46:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make highly niced processes run only when idle
Message-ID: <20011209184656.E8846@redhat.com>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org> <1007939114.878.1.camel@phantasy> <20011209181643.A8846@redhat.com> <1007940066.878.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1007940066.878.7.camel@phantasy>; from rml@tech9.net on Sun, Dec 09, 2001 at 06:21:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 06:21:05PM -0500, Robert Love wrote:
> Ahh ... wait, do you mean periodically run them, but only give them the
> boost while they are in kernel space?  Very good idea.  Can you see an
> easy way to do this?

Actually, yes: in entry.S the ret_from_syscall path which calls schedule 
can be changed to pass a parameter indicating it is returning to userspace 
afterwards which would let schedule know the bump is not needed.

		-ben
-- 
Fish.

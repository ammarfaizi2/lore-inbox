Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUFRX2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUFRX2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUFRX2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:28:17 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48477 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265781AbUFRX1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:27:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Date: Fri, 18 Jun 2004 19:26:39 -0400
User-Agent: KMail/1.6.2
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com> <20040619000326.067c3ff6.ak@suse.de>
In-Reply-To: <20040619000326.067c3ff6.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181926.39294.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 18, 2004 6:03 pm, Andi Kleen wrote:
> On Fri, 18 Jun 2004 15:03:00 -0500
>
> Brent Casavant <bcasavan@sgi.com> wrote:
> > On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
> > determine WCHAN symbol name information.  This information is provided
> > by the kernel function kallsyms_lookup(), which expands a stem-compressed
>
> That sounds more like a bug in your top to me. /proc/*/wchan itself
> does not access kallsyms, it just outputs a number.undisclosed-recipients:;

No, it outputs a string:
jbarnes@mill:~$ cat /proc/1/wchan
do_select

I haven't looked, but it's probably dependent on CONFIG_KALLSYMS.

> Doing the cache in the kernel is the wrong place. This should be fixed
> in user space.

Sure, but that would be a change in behavior.  It's arguably the right thing 
to do though.

Jesse

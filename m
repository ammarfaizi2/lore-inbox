Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318042AbSGWMX4>; Tue, 23 Jul 2002 08:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSGWMX4>; Tue, 23 Jul 2002 08:23:56 -0400
Received: from ns.suse.de ([213.95.15.193]:62990 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318042AbSGWMXy>;
	Tue, 23 Jul 2002 08:23:54 -0400
Date: Tue, 23 Jul 2002 14:27:04 +0200
From: Dave Jones <davej@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marcin Dalecki <dalecki@evision.ag>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 enum
Message-ID: <20020723142704.B14323@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Marcin Dalecki <dalecki@evision.ag>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE421.3040800@evision.ag> <20020722160118.G6428@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722160118.G6428@redhat.com>; from bcrl@redhat.com on Mon, Jul 22, 2002 at 04:01:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 04:01:18PM -0400, Benjamin LaHaise wrote:
 > On Mon, Jul 22, 2002 at 12:53:21PM +0200, Marcin Dalecki wrote:
 > > - Fix a bunch of places where there are trailing "," at the
 > >    end of enum declarations.
 > 
 > Please don't apply this.  By leaving the trailing "," on enums, additional 
 > values can be added by merely inserting an additional + line in a patch, 
 > otherwise there are excess conflicts when multiple patches add values to 
 > the enum.

Gratuitous 'cleanups' with no real redeeming feature also have another
downside which a lot of people seem to overlook.  They completely screws
over anyone who also has a pending patch in that area if Linus applies it.

For most people this is five minutes work as they fix up by hand
the single reject in one or two places.  For people like myself keeping
a large patchset, this is a lot of extra work for absolutely no gain.
Two kernels later, someone adds a new sysctl which re-adds the , at
the end anyway.

We have much bigger problems to fix than silly[1] things like this.

        Dave

[1] Maybe silly is the wrong word to use, but I didn't want to use
    'trivial' for fear of putting down the usefulness of Rusty's
    trivial patches.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

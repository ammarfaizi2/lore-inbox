Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVADUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVADUOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVADUNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:13:09 -0500
Received: from holomorphy.com ([207.189.100.168]:52874 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262065AbVADUA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:00:56 -0500
Date: Tue, 4 Jan 2005 11:57:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104195725.GQ2708@holomorphy.com>
References: <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104165301.GF3097@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 07:34:45AM -0800, William Lee Irwin III wrote:
>> The less that happens, the less likely it is for anything to happen.
>> You're effectively arguing that very little should happen.
>> This cannot be, because pure bugfixing activity alone would overwhelm
>> the limits on levels of activity you endorse. When it comes to design
>> flaws, a single fix for such would swamp the limits on activity you've
>> imposed for a significant portion of a year.

On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> My opinion is to fork 2.7 pretty soon and to allow into 2.6 only the 
> amount of changes that were allowed into 2.4 after 2.5 forked.
> Looking at 2.4, this seems to be a promising model.

This must be considered relative to the size of the source code.
Just because they're more changes than you can personally track does
not mean they're large numbers of changes relative to the source's size.

Users' timidity in these regards should be taken as little more than
a sign that the scale of the kernel's source is increasing, which is a
good thing, as the kernel may then benefit from economies of scale.

The kernel's scale has long since increased beyond the point where an
individual can effectively track its changes in realtime, and small
matters of degree such as are being moaned about now are insubstantial.
Similarly, counts of bugs and regressions should probably also be
considered relative to the size of the kernel source.


On Tue, Jan 04, 2005 at 07:34:45AM -0800, William Lee Irwin III wrote:
>> If you want more stability and fewer regressions, look for methods of
>> getting more peer review for patches, not fewer patches.

On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> This is only one source of problems, that increases with the amount of 
> changes and decreases with the amount of review.
> Another source is the interaction of correct patches with other code. An 
> example are (were?) the problems with 4kB stacks on i386 with XFS.

The existences of badly-behaved filesystems and drivers were known in
advance, and that's why 4KB stacks were left optional. So the example
is not particularly enlightening.

This is trivially countered with the source code skew that crippled
numerous architectures, made numerous drivers uncompilable or
unrunnable and the like over the course of the "unstable series". Had
the attention of users of the stable series been present, no such
phenomena would have occurred.

The issues you're dredging up are pinpricks at most. The losses
incurred from the fragmentation of the userbase are far more severe,
dwarfing those by numerous orders of magnitude.


On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> And then there are issues that are not bugs in the code, but user errors 
> that have to be avoided. An example is CONFIG_BLK_DEV_UB in 2.6.9, which 
> even the Debian kernel maintainers got wrong in the first kernel 
> packages they did put into Debian unstable.

PEBKAC is entirely out of the scope of any program not making direct
efforts at HCI. CONFIG_BLK_DEV_UB was documented for what it was, and
users configuring kernels are not assumed to be naive.


-- wli

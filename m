Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264666AbUD1Fp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbUD1Fp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbUD1Fp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:45:58 -0400
Received: from opersys.com ([64.40.108.71]:62480 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264666AbUD1Fp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:45:56 -0400
Message-ID: <408F4658.9050109@opersys.com>
Date: Wed, 28 Apr 2004 01:51:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What does tainting actually mean?
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nigel Cunningham wrote:
> What I mean is, how does it help to know that a kernel is tainted? When  
> I'm working on Software Suspend and someone sends me an oops, I don't  
> really care whether it's marked as tainted or not. For all I know, even 
> if  it's not tainted, they may have thrown in half a dozen different 
> patches  aside from Suspend, any one of which could be playing a role in 
> the  appearance of the oops. It doesn't help me to know that the kernel 

The legal/moral implications of taint/binary-mods/etc. aside, I think it
may be worth putting some thought into coming up with a way to identify
which patches were applied to a kernel -- given the wide-spread use of this
method to add/remove/amend kernel functionality. Maybe there should be a
/proc/sys/kernel/patches file at runtime which would provide a list of
applied patches and some characteristics/description? When patches are
applied, there could then be a toplevel .patches file which all patch
submitters/providers/distributors would be strongly encouraged or
<form>insert your favorite coercive method or torture technique here</form>
to amend as they add their code. At build time, the makefile could then
use this file the generate some header used by the code printing out the
/proc/sys/kernel/patches. At oops time, the content of this file would also
be part of the dump.

Note: such a mechanism is not an alternative to "tainting", it's an
additional tool for trying to identify potential problems. I, for one,
would love to be able to find out which patches the various distro vendor
have found useful to include with their kernel. Currently, this takes more
time than I'm willing to invest ... at least until something serious
comes up ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


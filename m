Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTJBSjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTJBSjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:39:25 -0400
Received: from opersys.com ([64.40.108.71]:56077 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263448AbTJBSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:39:08 -0400
Message-ID: <3F7C7180.2020404@opersys.com>
Date: Thu, 02 Oct 2003 14:42:08 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: "Theodore Ts'o" <tytso@mit.edu>, xen-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jacques Gelinas <jack@solucorp.qc.ca>
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
References: <E1A57B6-0007y9-00@wisbech.cl.cam.ac.uk>
In-Reply-To: <E1A57B6-0007y9-00@wisbech.cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keir Fraser wrote:
> Full recursion needs full virtualization. Our approach offers much
> better performance in the situations where full virtualization isn't
> required -- i.e., where it's feasible to distribute a ported OS.

I noticed that the SOSP Xen paper briefly mentions Jacques Gelinas' work
on VServers (http://www.solucorp.qc.ca/miscprj/s_context.hc). While
Jacques' work hasn't attracted as much public attention as other Linux
virtualization efforts, I've personally found the approach and concepts
quite fascinating. Among other things, most of the code implementing the
contexts is architecture-independent (save for a few syscalls added to
arch/*/kernel/entry.S). So, thinking aloud here, I'm wondering in what
circumstances I'd prefer using something as architecture specific as
Xen over something as architecture independent as Jacques' VServers?
(Granted VServers can't run Windows, but I'm asking this from the angle
of people looking for resource isolation in the Linux context.) Among
other things, VServers are already in use by many ISPs to provide
simultaneous hosting of many "virtual machines" on the same box while
maintaining strict separation between machines and still providing a
secure environment.

Karim

P.S.:
For those who aren't familiar with Jacques' stuff, have a look at this
document here:
http://www.solucorp.qc.ca/miscprj/s_context.hc?prjstate=1&nodoc=0
The actual concepts implemented in VServers are here:
http://www.solucorp.qc.ca/miscprj/s_context.hc?s1=2&s2=0&s3=0&s4=0&full=0&prjstate=1&nodoc=0
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

